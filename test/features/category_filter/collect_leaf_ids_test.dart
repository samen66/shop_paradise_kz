import 'package:flutter_test/flutter_test.dart';
import 'package:shop_paradise_kz/features/category_filter/domain/entities/category_filter_entities.dart';
import 'package:shop_paradise_kz/features/category_filter/presentation/providers/category_filter_providers.dart';

void main() {
  group('collectLeafCategoryIds', () {
    test('should return only leaf ids from a shallow tree', () {
      const List<CategoryNodeEntity> roots = <CategoryNodeEntity>[
        CategoryNodeEntity(
          id: 'a',
          title: 'A',
          children: <CategoryNodeEntity>[
            CategoryNodeEntity(id: 'leaf1', title: 'L1'),
            CategoryNodeEntity(id: 'leaf2', title: 'L2'),
          ],
        ),
      ];
      final List<String> leaves = collectLeafCategoryIds(roots);
      expect(leaves, <String>['leaf1', 'leaf2']);
    });
  });
}
