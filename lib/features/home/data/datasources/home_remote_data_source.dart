import 'dart:async';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/home_models.dart';

class HomeRemoteDataSource {
  const HomeRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<HomeResponseModel> fetchHomeSections() async {
    try {
      final Map<String, dynamic> response = await _apiClient.getJson(
        ApiEndpoints.homeSections,
      );
      return HomeResponseModel.fromJson(response);
    } catch (_) {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      return HomeResponseModel.fromJson(_mockHomePayload(page: 2));
    }
  }

  /// Query uses comma-separated `category_ids` when [categoryIds] is non-empty.
  Future<HomeSectionModel> fetchJustForYouPage(
    int page, {
    List<String> categoryIds = const <String>[],
  }) async {
    final Map<String, dynamic> queryParameters = <String, dynamic>{
      'page': page,
    };
    if (categoryIds.isNotEmpty) {
      queryParameters['category_ids'] = categoryIds.join(',');
    }
    try {
      final Map<String, dynamic> response = await _apiClient.getJson(
        '${ApiEndpoints.homeSections}/just-for-you',
        queryParameters: queryParameters,
      );
      return HomeSectionModel.fromJson(
        response['section'] as Map<String, dynamic>,
      );
    } catch (_) {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      return _mockJustForYouSection(page: page, categoryIds: categoryIds);
    }
  }
}

Map<String, dynamic> _mockHomePayload({required int page}) => <String, dynamic>{
  'sections': <Map<String, dynamic>>[
    <String, dynamic>{
      'type': 'categories',
      'title': 'Categories',
      'layout': 'horizontal',
      'items': List<Map<String, dynamic>>.generate(
        8,
        (int index) => <String, dynamic>{
          'id': 'category_$index',
          'title': 'Category ${index + 1}',
          'image_url': 'https://picsum.photos/seed/c$index/120/120',
        },
      ),
    },
    <String, dynamic>{
      'type': 'products',
      'title': 'Top Products',
      'layout': 'circles',
      'items': List<Map<String, dynamic>>.generate(
        8,
        (int index) => <String, dynamic>{
          'id': 'top_$index',
          'title': 'Top Item ${index + 1}',
          'image_url': 'https://picsum.photos/seed/t$index/240/240',
          'price': 12 + index * 3,
        },
      ),
    },
    <String, dynamic>{
      'type': 'new_items',
      'title': 'New Items',
      'layout': 'horizontal',
      'items': List<Map<String, dynamic>>.generate(
        5,
        (int index) => <String, dynamic>{
          'id': 'new_$index',
          'title': 'New Sneaker ${index + 1}',
          'image_url': 'https://picsum.photos/seed/n$index/320/220',
          'price': 21 + index * 2,
        },
      ),
    },
    <String, dynamic>{
      'type': 'flash_sale',
      'title': 'Flash Sale',
      'layout': 'grid_2',
      'items': List<Map<String, dynamic>>.generate(
        6,
        (int index) => <String, dynamic>{
          'id': 'flash_$index',
          'title': 'Flash Item ${index + 1}',
          'image_url': 'https://picsum.photos/seed/f$index/320/220',
          'price': 18 + index,
          'old_price': 30 + index,
          'discount_label': '${30 + index}%',
        },
      ),
    },
    <String, dynamic>{
      'type': 'most_popular',
      'title': 'Most Popular',
      'layout': 'grid_2',
      'items': List<Map<String, dynamic>>.generate(
        4,
        (int index) => <String, dynamic>{
          'id': 'popular_$index',
          'title': 'Popular ${index + 1}',
          'image_url': 'https://picsum.photos/seed/p$index/320/220',
          'price': 19 + index * 4,
        },
      ),
    },
    _mockJustForYouSectionMap(page: page),
  ],
};

/// Leaf ids aligned with [mockCategoryTreeJson] in category_filter datasource.
const List<String> _mockJfyCategoryLeaves = <String>[
  'dresses',
  'pants',
  'skirts',
  'shorts',
  'jackets',
  'hoodies',
  'shirts',
  'polo',
  't_shirts',
  'tunics',
  'sneakers',
  'boots',
  'sandals',
  'handbags',
  'backpacks',
];

HomeSectionModel _mockJustForYouSection({
  required int page,
  List<String> categoryIds = const <String>[],
}) {
  final Map<String, dynamic> map = _mockJustForYouSectionMap(page: page);
  if (categoryIds.isEmpty) {
    return HomeSectionModel.fromJson(map);
  }
  final List<dynamic> items = map['items'] as List<dynamic>;
  final Set<String> wanted = categoryIds.toSet();
  final List<Map<String, dynamic>> filtered = items
      .where((dynamic raw) {
        final Map<String, dynamic> item = raw as Map<String, dynamic>;
        final List<dynamic>? tags = item['category_ids'] as List<dynamic>?;
        if (tags == null || tags.isEmpty) {
          return false;
        }
        for (final dynamic t in tags) {
          if (wanted.contains(t as String)) {
            return true;
          }
        }
        return false;
      })
      .cast<Map<String, dynamic>>()
      .toList();
  return HomeSectionModel.fromJson(<String, dynamic>{
    ...map,
    'items': filtered,
    'has_more': page < 4 && filtered.isNotEmpty,
  });
}

Map<String, dynamic> _mockJustForYouSectionMap({required int page}) =>
    <String, dynamic>{
      'type': 'just_for_you',
      'title': 'Just For You',
      'layout': 'grid_2',
      'has_more': page < 4,
      'next_page': page + 1,
      'items': List<Map<String, dynamic>>.generate(8, (int index) {
        final int cursor = (page - 1) * 8 + index;
        final String tag =
            _mockJfyCategoryLeaves[cursor % _mockJfyCategoryLeaves.length];
        return <String, dynamic>{
          'id': 'jfy_$cursor',
          'title': 'Recommended ${cursor + 1} ($tag)',
          'image_url': 'https://picsum.photos/seed/j$cursor/360/320',
          'price': 24 + (cursor % 6) * 3,
          'category_ids': <String>[tag],
        };
      }),
    };
