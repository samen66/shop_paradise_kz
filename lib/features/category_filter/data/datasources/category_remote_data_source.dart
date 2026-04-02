import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/category_filter_models.dart';

class CategoryRemoteDataSource {
  const CategoryRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  /// Fetches category tree. On failure returns [mockCategoryTreeJson] parsed.
  Future<List<CategoryNodeModel>> fetchCategoryTree() async {
    try {
      final Map<String, dynamic> response = await _apiClient.getJson(
        ApiEndpoints.categories,
      );
      final List<dynamic> list =
          response['categories'] as List<dynamic>? ?? <dynamic>[];
      return list
          .map(
            (dynamic e) =>
                CategoryNodeModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(growable: false);
    } catch (_) {
      return _parseMockCategories(mockCategoryTreeJson());
    }
  }
}

List<CategoryNodeModel> _parseMockCategories(Map<String, dynamic> json) {
  final List<dynamic> list =
      json['categories'] as List<dynamic>? ?? <dynamic>[];
  return list
      .map((dynamic e) => CategoryNodeModel.fromJson(e as Map<String, dynamic>))
      .toList(growable: false);
}

/// Deterministic mock aligned with accordion + subcategory grid samples.
Map<String, dynamic> mockCategoryTreeJson() => <String, dynamic>{
  'categories': <Map<String, dynamic>>[
    <String, dynamic>{
      'id': 'clothing',
      'title': 'Clothing',
      'image_url': 'https://picsum.photos/seed/cat-clothing/120/120',
      'children': <Map<String, dynamic>>[
        <String, dynamic>{'id': 'dresses', 'title': 'Dresses'},
        <String, dynamic>{'id': 'pants', 'title': 'Pants'},
        <String, dynamic>{'id': 'skirts', 'title': 'Skirts'},
        <String, dynamic>{'id': 'shorts', 'title': 'Shorts'},
        <String, dynamic>{'id': 'jackets', 'title': 'Jackets'},
        <String, dynamic>{'id': 'hoodies', 'title': 'Hoodies'},
        <String, dynamic>{'id': 'shirts', 'title': 'Shirts'},
        <String, dynamic>{'id': 'polo', 'title': 'Polo'},
        <String, dynamic>{'id': 't_shirts', 'title': 'T-Shirts'},
        <String, dynamic>{'id': 'tunics', 'title': 'Tunics'},
      ],
    },
    <String, dynamic>{
      'id': 'shoes',
      'title': 'Shoes',
      'image_url': 'https://picsum.photos/seed/cat-shoes/120/120',
      'children': <Map<String, dynamic>>[
        <String, dynamic>{'id': 'sneakers', 'title': 'Sneakers'},
        <String, dynamic>{'id': 'boots', 'title': 'Boots'},
        <String, dynamic>{'id': 'sandals', 'title': 'Sandals'},
      ],
    },
    <String, dynamic>{
      'id': 'bags',
      'title': 'Bags',
      'image_url': 'https://picsum.photos/seed/cat-bags/120/120',
      'children': <Map<String, dynamic>>[
        <String, dynamic>{'id': 'handbags', 'title': 'Handbags'},
        <String, dynamic>{'id': 'backpacks', 'title': 'Backpacks'},
      ],
    },
  ],
};
