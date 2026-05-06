import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drift/drift.dart';

import '../domain/entities/shopping_note_entity.dart';
import '../domain/entities/spending_category_entity.dart';
import '../domain/repositories/shopping_notes_repository.dart';
import 'drift/shopping_notes_database.dart';
import 'notes_remote_data_source.dart';

/// Persists to Drift first; when online, attempts a mock HTTP sync and flags rows.
class ShoppingNotesRepositoryImpl implements ShoppingNotesRepository {
  ShoppingNotesRepositoryImpl({
    required ShoppingNotesDatabase database,
    required NotesRemoteDataSource remote,
    Connectivity? connectivity,
  })  : _db = database,
        _remote = remote,
        _connectivity = connectivity ?? Connectivity();

  final ShoppingNotesDatabase _db;
  final NotesRemoteDataSource _remote;
  final Connectivity _connectivity;

  @override
  Stream<List<ShoppingNoteEntity>> watchNotes() {
    return _db.watchAllNotes().map(_mapNoteRecords);
  }

  @override
  Future<List<ShoppingNoteEntity>> getNotes() async {
    final List<ShoppingNoteRecord> rows = await _db.allNotes;
    return _mapNoteRecords(rows);
  }

  @override
  Stream<List<SpendingCategoryEntity>> watchCategories() {
    return _db.watchAllCategories().map(_mapCategoryRecords);
  }

  @override
  Future<List<SpendingCategoryEntity>> getCategories() async {
    final List<SpendingCategoryRecord> rows = await _db.allCategories;
    return _mapCategoryRecords(rows);
  }

  @override
  Future<int> createCategory(String name) async {
    final String trimmed = name.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError.value(name, 'name', 'must not be empty');
    }
    final List<SpendingCategoryRecord> existing = await _db.allCategories;
    final bool taken = existing.any(
      (SpendingCategoryRecord e) =>
          e.name.toLowerCase() == trimmed.toLowerCase(),
    );
    if (taken) {
      throw StateError('Category name already exists: $trimmed');
    }
    final DateTime now = DateTime.now();
    return _db.insertCategoryRow(
      SpendingCategoryRecordsCompanion.insert(
        name: trimmed,
        createdAt: Value<DateTime>(now),
        updatedAt: Value<DateTime>(now),
      ),
    );
  }

  @override
  Future<void> updateCategory(SpendingCategoryEntity category) async {
    final String trimmed = category.name.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError.value(category.name, 'name', 'must not be empty');
    }
    final List<SpendingCategoryRecord> all = await _db.allCategories;
    final bool taken = all.any(
      (SpendingCategoryRecord e) =>
          e.id != category.id &&
          e.name.toLowerCase() == trimmed.toLowerCase(),
    );
    if (taken) {
      throw StateError('Category name already exists: $trimmed');
    }
    final DateTime now = DateTime.now();
    final SpendingCategoryRecord row =
        await (_db.select(_db.spendingCategoryRecords)
              ..where((tbl) => tbl.id.equals(category.id)))
            .getSingle();
    await _db.updateCategoryRow(
      row.copyWith(name: trimmed, updatedAt: now),
    );
    await _db.rewriteCategoryLabelForNotes(
      categoryId: category.id,
      label: trimmed,
    );
  }

  @override
  Future<bool> deleteCategoryIfUnused(int id) async {
    final int n = await _db.countNotesWithCategoryId(id);
    if (n > 0) {
      return false;
    }
    await _db.deleteCategoryRow(id);
    return true;
  }

  @override
  Future<void> createNote({
    required String title,
    required String body,
    required int categoryId,
    required double amount,
  }) async {
    final SpendingCategoryRecord cat =
        await (_db.select(_db.spendingCategoryRecords)
              ..where((tbl) => tbl.id.equals(categoryId)))
            .getSingle();
    final DateTime now = DateTime.now();
    final int id = await _db.insertNote(
      ShoppingNoteRecordsCompanion.insert(
        title: title.trim(),
        body: Value<String>(body.trim()),
        category: Value<String>(cat.name),
        categoryId: Value<int>(categoryId),
        amount: Value<double>(amount),
        syncedToRemote: const Value<bool>(false),
        createdAt: Value<DateTime>(now),
        updatedAt: Value<DateTime>(now),
      ),
    );
    if (await isDeviceOnline()) {
      try {
        await _remote.pushNotePayload(<String, dynamic>{
          'id': id,
          'title': title.trim(),
          'category': cat.name,
          'amount': amount,
        });
        final ShoppingNoteRecord row =
            await (_db.select(_db.shoppingNoteRecords)
                  ..where((tbl) => tbl.id.equals(id)))
                .getSingle();
        await _db.updateNote(
          row.copyWith(syncedToRemote: true, updatedAt: DateTime.now()),
        );
      } on Object {
        // Offline-quality: row stays local with syncedToRemote false.
      }
    }
  }

  @override
  Future<void> updateNote(ShoppingNoteEntity note) async {
    final ShoppingNoteRecord row =
        await (_db.select(_db.shoppingNoteRecords)
              ..where((tbl) => tbl.id.equals(note.id)))
            .getSingle();
    final int? cid = note.categoryId;
    late final String categoryLabel;
    if (cid != null) {
      final SpendingCategoryRecord cat =
          await (_db.select(_db.spendingCategoryRecords)
                ..where((tbl) => tbl.id.equals(cid)))
              .getSingle();
      categoryLabel = cat.name;
    } else {
      final String raw = note.category.trim();
      categoryLabel = raw.isEmpty ? 'General' : raw;
    }
    final DateTime now = DateTime.now();
    final ShoppingNoteRecord updated = row.copyWith(
      title: note.title.trim(),
      body: note.body.trim(),
      category: categoryLabel,
      categoryId: Value<int?>(cid ?? row.categoryId),
      amount: note.amount,
      updatedAt: now,
      syncedToRemote: false,
    );
    await _db.updateNote(updated);
    if (await isDeviceOnline()) {
      try {
        await _remote.pushNotePayload(<String, dynamic>{
          'id': note.id,
          'title': note.title,
          'category': categoryLabel,
          'amount': note.amount,
        });
        final ShoppingNoteRecord after =
            await (_db.select(_db.shoppingNoteRecords)
                  ..where((tbl) => tbl.id.equals(note.id)))
                .getSingle();
        await _db.updateNote(
          after.copyWith(syncedToRemote: true, updatedAt: DateTime.now()),
        );
      } on Object {
        // keep unsynced
      }
    }
  }

  @override
  Future<void> deleteNote(int id) async {
    await _db.deleteNote(id);
  }

  @override
  Future<Map<String, double>> sumsByCategory() => _db.sumsByCategory();

  @override
  Future<bool> isDeviceOnline() async {
    final List<ConnectivityResult> r = await _connectivity.checkConnectivity();
    return r.any((ConnectivityResult e) => e != ConnectivityResult.none);
  }

  List<ShoppingNoteEntity> _mapNoteRecords(List<ShoppingNoteRecord> rows) {
    return rows
        .map(
          (ShoppingNoteRecord r) => ShoppingNoteEntity(
            id: r.id,
            title: r.title,
            body: r.body,
            category: r.category,
            categoryId: r.categoryId,
            amount: r.amount,
            syncedToRemote: r.syncedToRemote,
            createdAt: r.createdAt,
            updatedAt: r.updatedAt,
          ),
        )
        .toList(growable: false);
  }

  List<SpendingCategoryEntity> _mapCategoryRecords(
    List<SpendingCategoryRecord> rows,
  ) {
    return rows
        .map(
          (SpendingCategoryRecord r) => SpendingCategoryEntity(
            id: r.id,
            name: r.name,
            createdAt: r.createdAt,
            updatedAt: r.updatedAt,
          ),
        )
        .toList(growable: false);
  }
}
