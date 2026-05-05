/// Domain model for a local shopping note / price line (offline CRUD).
class ShoppingNoteEntity {
  const ShoppingNoteEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.category,
    required this.categoryId,
    required this.amount,
    required this.syncedToRemote,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String title;
  final String body;
  final String category;
  /// FK to [SpendingCategoryEntity]; null for legacy rows pre-migration.
  final int? categoryId;
  final double amount;
  final bool syncedToRemote;
  final DateTime createdAt;
  final DateTime updatedAt;
}
