/// Domain model for a spending category preset (second entity type; local CRUD).
class SpendingCategoryEntity {
  const SpendingCategoryEntity({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
}
