import '../../domain/entities/home_entities.dart';

class HomeItemModel {
  const HomeItemModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.price,
    this.oldPrice,
    this.discountLabel,
    this.categoryIds = const <String>[],
  });

  factory HomeItemModel.fromJson(Map<String, dynamic> json) => HomeItemModel(
    id: json['id'] as String,
    title: json['title'] as String? ?? '',
    imageUrl: json['image_url'] as String? ?? '',
    price: (json['price'] as num?)?.toDouble(),
    oldPrice: (json['old_price'] as num?)?.toDouble(),
    discountLabel: json['discount_label'] as String?,
    categoryIds:
        (json['category_ids'] as List<dynamic>?)
            ?.map((dynamic e) => e as String)
            .toList(growable: false) ??
        const <String>[],
  );

  final String id;
  final String title;
  final String imageUrl;
  final double? price;
  final double? oldPrice;
  final String? discountLabel;
  final List<String> categoryIds;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'title': title,
    'image_url': imageUrl,
    'price': price,
    'old_price': oldPrice,
    'discount_label': discountLabel,
    'category_ids': categoryIds,
  };

  HomeItemEntity toEntity() => HomeItemEntity(
    id: id,
    title: title,
    imageUrl: imageUrl,
    price: price,
    oldPrice: oldPrice,
    discountLabel: discountLabel,
    categoryIds: categoryIds,
  );
}

class HomeSectionModel {
  const HomeSectionModel({
    required this.type,
    required this.title,
    required this.layout,
    required this.items,
    this.hasMore = false,
    this.nextPage = 1,
  });

  factory HomeSectionModel.fromJson(Map<String, dynamic> json) =>
      HomeSectionModel(
        type: json['type'] as String? ?? 'unknown',
        title: json['title'] as String? ?? '',
        layout: json['layout'] as String? ?? 'horizontal',
        items: (json['items'] as List<dynamic>? ?? <dynamic>[])
            .map(
              (dynamic item) =>
                  HomeItemModel.fromJson(item as Map<String, dynamic>),
            )
            .toList(growable: false),
        hasMore: json['has_more'] as bool? ?? false,
        nextPage: json['next_page'] as int? ?? 1,
      );

  final String type;
  final String title;
  final String layout;
  final List<HomeItemModel> items;
  final bool hasMore;
  final int nextPage;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'type': type,
    'title': title,
    'layout': layout,
    'items': items.map((HomeItemModel item) => item.toJson()).toList(),
    'has_more': hasMore,
    'next_page': nextPage,
  };

  HomeSectionEntity toEntity() => HomeSectionEntity(
    type: _mapSectionType(type),
    title: title,
    layout: _mapSectionLayout(layout),
    items: items.map((HomeItemModel item) => item.toEntity()).toList(),
    hasMore: hasMore,
    nextPage: nextPage,
  );
}

class HomeResponseModel {
  const HomeResponseModel({required this.sections});

  factory HomeResponseModel.fromJson(Map<String, dynamic> json) =>
      HomeResponseModel(
        sections: (json['sections'] as List<dynamic>? ?? <dynamic>[])
            .map(
              (dynamic item) =>
                  HomeSectionModel.fromJson(item as Map<String, dynamic>),
            )
            .toList(growable: false),
      );

  final List<HomeSectionModel> sections;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'sections': sections
        .map((HomeSectionModel section) => section.toJson())
        .toList(),
  };

  HomePageEntity toEntity() => HomePageEntity(
    sections: sections
        .map((HomeSectionModel section) => section.toEntity())
        .toList(),
  );
}

HomeSectionType _mapSectionType(String rawType) {
  switch (rawType) {
    case 'categories':
      return HomeSectionType.categories;
    case 'products':
      return HomeSectionType.products;
    case 'new_items':
      return HomeSectionType.newItems;
    case 'flash_sale':
      return HomeSectionType.flashSale;
    case 'most_popular':
      return HomeSectionType.mostPopular;
    case 'just_for_you':
      return HomeSectionType.justForYou;
    default:
      return HomeSectionType.unknown;
  }
}

HomeSectionLayout _mapSectionLayout(String rawLayout) {
  switch (rawLayout) {
    case 'grid_2':
      return HomeSectionLayout.grid2;
    case 'circles':
      return HomeSectionLayout.circles;
    default:
      return HomeSectionLayout.horizontal;
  }
}
