import 'package:flutter_test/flutter_test.dart';
import 'package:shop_paradise_kz/features/home/data/models/home_models.dart';
import 'package:shop_paradise_kz/features/home/domain/entities/home_entities.dart';

void main() {
  test('HomeResponseModel maps sections and items from backend JSON', () {
    final Map<String, dynamic> json = <String, dynamic>{
      'sections': <Map<String, dynamic>>[
        <String, dynamic>{
          'type': 'categories',
          'title': 'Categories',
          'layout': 'horizontal',
          'items': <Map<String, dynamic>>[
            <String, dynamic>{
              'id': 'c1',
              'title': 'Shoes',
              'image_url': 'https://example.com/1.png',
            },
          ],
        },
      ],
    };

    final HomeResponseModel response = HomeResponseModel.fromJson(json);
    final HomePageEntity entity = response.toEntity();

    expect(entity.sections.length, 1);
    expect(entity.sections.first.type, HomeSectionType.categories);
    expect(entity.sections.first.items.first.title, 'Shoes');
  });
}
