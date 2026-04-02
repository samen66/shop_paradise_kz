import 'package:flutter/material.dart';

import '../../domain/entities/category_filter_entities.dart';
import 'subcategory_selectable_chip.dart';

bool categoryMatchesSearch(CategoryNodeEntity node, String query) {
  final String q = query.trim().toLowerCase();
  if (q.isEmpty) {
    return true;
  }
  if (node.title.toLowerCase().contains(q)) {
    return true;
  }
  for (final CategoryNodeEntity child in node.children) {
    if (child.title.toLowerCase().contains(q)) {
      return true;
    }
  }
  return false;
}

/// Parent row + expandable 2-column grid of leaf subcategories.
class CategoryParentExpansionTile extends StatelessWidget {
  const CategoryParentExpansionTile({
    super.key,
    required this.node,
    required this.selectedIds,
    required this.onToggleLeaf,
    required this.searchQuery,
  });

  final CategoryNodeEntity node;
  final Set<String> selectedIds;
  final void Function(String id) onToggleLeaf;
  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    if (!categoryMatchesSearch(node, searchQuery)) {
      return const SizedBox.shrink();
    }
    final List<CategoryNodeEntity> visibleChildren = node.children
        .where((CategoryNodeEntity c) {
          final String q = searchQuery.trim().toLowerCase();
          if (q.isEmpty) {
            return true;
          }
          return c.title.toLowerCase().contains(q) ||
              node.title.toLowerCase().contains(q);
        })
        .toList(growable: false);
    if (visibleChildren.isEmpty) {
      return const SizedBox.shrink();
    }
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: node.imageUrl != null && node.imageUrl!.isNotEmpty
              ? Image.network(
                  node.imageUrl!,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const SizedBox(
                    width: 48,
                    height: 48,
                    child: ColoredBox(color: Color(0x22000000)),
                  ),
                )
              : const SizedBox(
                  width: 48,
                  height: 48,
                  child: ColoredBox(color: Color(0x22000000)),
                ),
        ),
        title: Text(
          node.title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        children: <Widget>[
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.4,
            ),
            itemCount: visibleChildren.length,
            itemBuilder: (BuildContext context, int index) {
              final CategoryNodeEntity leaf = visibleChildren[index];
              final bool isSelected = selectedIds.contains(leaf.id);
              return SubcategorySelectableChip(
                label: leaf.title,
                isSelected: isSelected,
                onTap: () => onToggleLeaf(leaf.id),
              );
            },
          ),
        ],
      ),
    );
  }
}
