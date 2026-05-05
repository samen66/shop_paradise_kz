import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/drift/shopping_notes_database.dart';
import '../../data/notes_remote_data_source.dart';
import '../../data/shopping_notes_repository_impl.dart';
import '../../domain/entities/shopping_note_entity.dart';
import '../../domain/entities/spending_category_entity.dart';
import '../../domain/repositories/shopping_notes_repository.dart';

final Provider<ShoppingNotesDatabase> shoppingNotesDatabaseProvider =
    Provider<ShoppingNotesDatabase>((Ref ref) {
  final ShoppingNotesDatabase db = ShoppingNotesDatabase();
  ref.onDispose(() {
    unawaited(db.close());
  });
  return db;
});

final Provider<ShoppingNotesRepository> shoppingNotesRepositoryProvider =
    Provider<ShoppingNotesRepository>((Ref ref) {
  return ShoppingNotesRepositoryImpl(
    database: ref.watch(shoppingNotesDatabaseProvider),
    remote: NotesRemoteDataSource(),
  );
});

final StreamProvider<List<ShoppingNoteEntity>> shoppingNotesStreamProvider =
    StreamProvider<List<ShoppingNoteEntity>>((Ref ref) {
  return ref.watch(shoppingNotesRepositoryProvider).watchNotes();
});

final StreamProvider<List<SpendingCategoryEntity>>
    spendingCategoriesStreamProvider =
    StreamProvider<List<SpendingCategoryEntity>>((Ref ref) {
  return ref.watch(shoppingNotesRepositoryProvider).watchCategories();
});

final StreamProvider<bool> connectivityStreamProvider = StreamProvider<bool>((
  Ref ref,
) async* {
  final Connectivity connectivity = Connectivity();
  bool online(List<ConnectivityResult> r) =>
      r.any((ConnectivityResult e) => e != ConnectivityResult.none);
  yield online(await connectivity.checkConnectivity());
  await for (final List<ConnectivityResult> event
      in connectivity.onConnectivityChanged) {
    yield online(event);
  }
});

final Provider<AsyncValue<Map<String, double>>> spendingByCategoryProvider =
    Provider<AsyncValue<Map<String, double>>>((Ref ref) {
  return ref.watch(shoppingNotesStreamProvider).whenData((
    List<ShoppingNoteEntity> notes,
  ) {
    final Map<String, double> m = <String, double>{};
    for (final ShoppingNoteEntity n in notes) {
      m[n.category] = (m[n.category] ?? 0) + n.amount;
    }
    return m;
  });
});
