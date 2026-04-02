import 'package:flutter_test/flutter_test.dart';
import 'package:shop_paradise_kz/features/home/data/models/home_models.dart';

void main() {
  group('HomeItemModel', () {
    test('should parse optional category_ids from JSON', () {
      final HomeItemModel model = HomeItemModel.fromJson(<String, dynamic>{
        'id': 'x',
        'title': 'Item',
        'image_url': 'https://example.com/i.png',
        'category_ids': <String>['dresses', 'skirts'],
      });
      expect(model.categoryIds, <String>['dresses', 'skirts']);
      expect(model.toEntity().categoryIds, <String>['dresses', 'skirts']);
    });
  });
}
