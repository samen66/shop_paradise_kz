import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'shopping_notes_database.g.dart';

/// Second entity table: category presets referenced by shopping notes.
class SpendingCategoryRecords extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name =>
      text().withLength(min: 1, max: 64).unique()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// Local rows for offline shopping notes (CRUD + chart source).
class ShoppingNoteRecords extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 1, max: 200)();

  TextColumn get body => text().withDefault(const Constant(''))();

  /// Denormalized label; kept in sync when the category row is renamed.
  TextColumn get category =>
      text().withLength(min: 1, max: 64).withDefault(const Constant('General'))();

  IntColumn get categoryId => integer().nullable().references(
        SpendingCategoryRecords,
        #id,
      )();

  RealColumn get amount => real().withDefault(const Constant(0))();

  BoolColumn get syncedToRemote =>
      boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(
  tables: <Type>[
    SpendingCategoryRecords,
    ShoppingNoteRecords,
  ],
)
class ShoppingNotesDatabase extends _$ShoppingNotesDatabase {
  ShoppingNotesDatabase([QueryExecutor? executor])
      : super(executor ?? _openConnection());

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'shopping_notes.sqlite');
  }

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          await _seedGeneralCategoryOnly();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 2) {
            await m.createTable(spendingCategoryRecords);
            await m.addColumn(
              shoppingNoteRecords,
              shoppingNoteRecords.categoryId,
            );
            await _backfillCategoriesFromV1Notes();
          }
        },
      );

  Future<void> _seedGeneralCategoryOnly() async {
    await into(spendingCategoryRecords).insert(
      SpendingCategoryRecordsCompanion.insert(name: 'General'),
    );
  }

  Future<void> _backfillCategoriesFromV1Notes() async {
    final List<ShoppingNoteRecord> rows =
        await select(shoppingNoteRecords).get();
    final Map<String, int> nameToId = <String, int>{};
    final DateTime now = DateTime.now();
    for (final ShoppingNoteRecord r in rows) {
      final String name = r.category;
      if (nameToId.containsKey(name)) {
        continue;
      }
      final int id = await into(spendingCategoryRecords).insert(
        SpendingCategoryRecordsCompanion.insert(
          name: name,
          createdAt: Value<DateTime>(r.createdAt),
          updatedAt: Value<DateTime>(now),
        ),
      );
      nameToId[name] = id;
    }
    if (nameToId.isEmpty) {
      await _seedGeneralCategoryOnly();
    }
    for (final ShoppingNoteRecord r in rows) {
      final int? cid = nameToId[r.category];
      if (cid != null) {
        await update(shoppingNoteRecords).replace(
          r.copyWith(categoryId: Value<int?>(cid)),
        );
      }
    }
  }

  Future<List<ShoppingNoteRecord>> get allNotes =>
      select(shoppingNoteRecords).get();

  Stream<List<ShoppingNoteRecord>> watchAllNotes() =>
      select(shoppingNoteRecords).watch();

  Future<List<SpendingCategoryRecord>> get allCategories =>
      select(spendingCategoryRecords).get();

  Stream<List<SpendingCategoryRecord>> watchAllCategories() =>
      select(spendingCategoryRecords).watch();

  Future<int> insertNote(ShoppingNoteRecordsCompanion row) =>
      into(shoppingNoteRecords).insert(row);

  Future<bool> updateNote(ShoppingNoteRecord row) =>
      update(shoppingNoteRecords).replace(row);

  Future<int> deleteNote(int id) =>
      (delete(shoppingNoteRecords)..where((tbl) => tbl.id.equals(id))).go();

  Future<int> insertCategoryRow(SpendingCategoryRecordsCompanion row) =>
      into(spendingCategoryRecords).insert(row);

  Future<bool> updateCategoryRow(SpendingCategoryRecord row) =>
      update(spendingCategoryRecords).replace(row);

  Future<int> deleteCategoryRow(int id) =>
      (delete(spendingCategoryRecords)..where((tbl) => tbl.id.equals(id))).go();

  Future<int> countNotesWithCategoryId(int categoryId) async {
    final List<ShoppingNoteRecord> rows =
        await (select(shoppingNoteRecords)
              ..where((tbl) => tbl.categoryId.equals(categoryId)))
            .get();
    return rows.length;
  }

  Future<void> rewriteCategoryLabelForNotes({
    required int categoryId,
    required String label,
  }) async {
    await (update(shoppingNoteRecords)
          ..where((tbl) => tbl.categoryId.equals(categoryId)))
        .write(
      ShoppingNoteRecordsCompanion(category: Value<String>(label)),
    );
  }

  Future<Map<String, double>> sumsByCategory() async {
    final List<ShoppingNoteRecord> all =
        await select(shoppingNoteRecords).get();
    final Map<String, double> out = <String, double>{};
    for (final ShoppingNoteRecord r in all) {
      out[r.category] = (out[r.category] ?? 0) + r.amount;
    }
    return out;
  }
}
