import '../entities/shopping_note_entity.dart';
import '../entities/spending_category_entity.dart';

/// Local-first notes and category presets with optional mock remote sync.
abstract class ShoppingNotesRepository {
  Stream<List<ShoppingNoteEntity>> watchNotes();

  Future<List<ShoppingNoteEntity>> getNotes();

  Stream<List<SpendingCategoryEntity>> watchCategories();

  Future<List<SpendingCategoryEntity>> getCategories();

  Future<int> createCategory(String name);

  Future<void> updateCategory(SpendingCategoryEntity category);

  /// Returns false when notes still reference this category.
  Future<bool> deleteCategoryIfUnused(int id);

  Future<void> createNote({
    required String title,
    required String body,
    required int categoryId,
    required double amount,
  });

  Future<void> updateNote(ShoppingNoteEntity note);

  Future<void> deleteNote(int id);

  /// Aggregated amounts per category label (for charts).
  Future<Map<String, double>> sumsByCategory();

  Future<bool> isDeviceOnline();
}
