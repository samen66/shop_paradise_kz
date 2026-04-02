/// One node in the category tree: parents have [children]; leaves have none.
class CategoryNodeEntity {
  const CategoryNodeEntity({
    required this.id,
    required this.title,
    this.imageUrl,
    this.children = const <CategoryNodeEntity>[],
  });

  final String id;
  final String title;
  final String? imageUrl;
  final List<CategoryNodeEntity> children;

  bool get isLeaf => children.isEmpty;
}
