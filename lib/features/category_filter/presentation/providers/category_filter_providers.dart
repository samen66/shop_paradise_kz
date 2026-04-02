import '../../domain/entities/category_filter_entities.dart';

export 'applied_category_filter_notifier.dart';
export 'category_filter_dependencies.dart';
export 'category_filter_draft_notifier.dart';
export 'category_tree_notifier.dart';

/// Collects ids of leaf nodes (selectable subcategories).
List<String> collectLeafCategoryIds(List<CategoryNodeEntity> roots) {
  final List<String> out = <String>[];
  void walk(CategoryNodeEntity node) {
    if (node.isLeaf) {
      out.add(node.id);
      return;
    }
    for (final CategoryNodeEntity child in node.children) {
      walk(child);
    }
  }

  for (final CategoryNodeEntity root in roots) {
    walk(root);
  }
  return out;
}
