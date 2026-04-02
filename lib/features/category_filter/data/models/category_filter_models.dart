import '../../domain/entities/category_filter_entities.dart';

class CategoryNodeModel {
  const CategoryNodeModel({
    required this.id,
    required this.title,
    this.imageUrl,
    this.children = const <CategoryNodeModel>[],
  });

  factory CategoryNodeModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> rawChildren =
        json['children'] as List<dynamic>? ?? <dynamic>[];
    return CategoryNodeModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      imageUrl: json['image_url'] as String?,
      children: rawChildren
          .map(
            (dynamic c) =>
                CategoryNodeModel.fromJson(c as Map<String, dynamic>),
          )
          .toList(growable: false),
    );
  }

  final String id;
  final String title;
  final String? imageUrl;
  final List<CategoryNodeModel> children;

  CategoryNodeEntity toEntity() => CategoryNodeEntity(
    id: id,
    title: title,
    imageUrl: imageUrl,
    children: children.map((CategoryNodeModel c) => c.toEntity()).toList(),
  );
}
