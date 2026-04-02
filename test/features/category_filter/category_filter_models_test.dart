import 'package:flutter_test/flutter_test.dart';
import 'package:shop_paradise_kz/features/category_filter/data/datasources/category_remote_data_source.dart';
import 'package:shop_paradise_kz/features/category_filter/data/models/category_filter_models.dart';

void main() {
  group('CategoryNodeModel', () {
    test('should map mock category tree JSON to nested models', () {
      final List<dynamic> categories =
          mockCategoryTreeJson()['categories']! as List<dynamic>;
      final CategoryNodeModel root = CategoryNodeModel.fromJson(
        categories.first as Map<String, dynamic>,
      );
      expect(root.id, 'clothing');
      expect(root.children.length, 10);
      expect(root.children.first.id, 'dresses');
    });
  });
}
