import '../../domain/entities/home_entities.dart';

class ProductVariationModel {
  const ProductVariationModel({
    required this.label,
    required this.value,
    this.previewImageUrls = const <String>[],
  });

  factory ProductVariationModel.fromJson(Map<String, dynamic> json) =>
      ProductVariationModel(
        label: json['label'] as String? ?? '',
        value: json['value'] as String? ?? '',
        previewImageUrls:
            (json['preview_image_urls'] as List<dynamic>?)
                ?.map((dynamic e) => e as String)
                .toList(growable: false) ??
            const <String>[],
      );

  final String label;
  final String value;
  final List<String> previewImageUrls;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'label': label,
    'value': value,
    'preview_image_urls': previewImageUrls,
  };

  ProductVariationEntity toEntity() => ProductVariationEntity(
    label: label,
    value: value,
    previewImageUrls: previewImageUrls,
  );
}

class ProductSpecificationModel {
  const ProductSpecificationModel({
    required this.name,
    this.values = const <String>[],
  });

  factory ProductSpecificationModel.fromJson(Map<String, dynamic> json) =>
      ProductSpecificationModel(
        name: json['name'] as String? ?? '',
        values:
            (json['values'] as List<dynamic>?)
                ?.map((dynamic e) => e as String)
                .toList(growable: false) ??
            const <String>[],
      );

  final String name;
  final List<String> values;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'values': values,
  };

  ProductSpecificationEntity toEntity() =>
      ProductSpecificationEntity(name: name, values: values);
}

class DeliveryOptionModel {
  const DeliveryOptionModel({
    required this.title,
    required this.etaLabel,
    required this.price,
  });

  factory DeliveryOptionModel.fromJson(Map<String, dynamic> json) =>
      DeliveryOptionModel(
        title: json['title'] as String? ?? '',
        etaLabel: json['eta_label'] as String? ?? '',
        price: (json['price'] as num?)?.toDouble() ?? 0,
      );

  final String title;
  final String etaLabel;
  final double price;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'title': title,
    'eta_label': etaLabel,
    'price': price,
  };

  DeliveryOptionEntity toEntity() =>
      DeliveryOptionEntity(title: title, etaLabel: etaLabel, price: price);
}

class ProductReviewPreviewModel {
  const ProductReviewPreviewModel({
    required this.overallRatingText,
    required this.authorName,
    required this.authorAvatarUrl,
    required this.comment,
    required this.rating,
  });

  factory ProductReviewPreviewModel.fromJson(Map<String, dynamic> json) =>
      ProductReviewPreviewModel(
        overallRatingText: json['overall_rating_text'] as String? ?? '',
        authorName: json['author_name'] as String? ?? '',
        authorAvatarUrl: json['author_avatar_url'] as String? ?? '',
        comment: json['comment'] as String? ?? '',
        rating: (json['rating'] as num?)?.toDouble() ?? 0,
      );

  final String overallRatingText;
  final String authorName;
  final String authorAvatarUrl;
  final String comment;
  final double rating;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'overall_rating_text': overallRatingText,
    'author_name': authorName,
    'author_avatar_url': authorAvatarUrl,
    'comment': comment,
    'rating': rating,
  };

  ProductReviewPreviewEntity toEntity() => ProductReviewPreviewEntity(
    overallRatingText: overallRatingText,
    authorName: authorName,
    authorAvatarUrl: authorAvatarUrl,
    comment: comment,
    rating: rating,
  );
}

class ProductDetailsModel {
  const ProductDetailsModel({
    required this.description,
    this.galleryImageUrls = const <String>[],
    this.variations = const <ProductVariationModel>[],
    this.specifications = const <ProductSpecificationModel>[],
    this.originLabel,
    this.sizeGuideLabel,
    this.deliveryOptions = const <DeliveryOptionModel>[],
    this.reviewPreview,
    this.mostPopularItems = const <HomeItemModel>[],
    this.youMightLikeItems = const <HomeItemModel>[],
  });

  factory ProductDetailsModel.fromJson(
    Map<String, dynamic> json,
  ) => ProductDetailsModel(
    description: json['description'] as String? ?? '',
    galleryImageUrls:
        (json['gallery_image_urls'] as List<dynamic>?)
            ?.map((dynamic e) => e as String)
            .toList(growable: false) ??
        const <String>[],
    variations: (json['variations'] as List<dynamic>? ?? <dynamic>[])
        .map(
          (dynamic item) =>
              ProductVariationModel.fromJson(item as Map<String, dynamic>),
        )
        .toList(growable: false),
    specifications: (json['specifications'] as List<dynamic>? ?? <dynamic>[])
        .map(
          (dynamic item) =>
              ProductSpecificationModel.fromJson(item as Map<String, dynamic>),
        )
        .toList(growable: false),
    originLabel: json['origin_label'] as String?,
    sizeGuideLabel: json['size_guide_label'] as String?,
    deliveryOptions: (json['delivery_options'] as List<dynamic>? ?? <dynamic>[])
        .map(
          (dynamic item) =>
              DeliveryOptionModel.fromJson(item as Map<String, dynamic>),
        )
        .toList(growable: false),
    reviewPreview: json['review_preview'] == null
        ? null
        : ProductReviewPreviewModel.fromJson(
            json['review_preview'] as Map<String, dynamic>,
          ),
    mostPopularItems:
        (json['most_popular_items'] as List<dynamic>? ?? <dynamic>[])
            .map(
              (dynamic item) =>
                  HomeItemModel.fromJson(item as Map<String, dynamic>),
            )
            .toList(growable: false),
    youMightLikeItems:
        (json['you_might_like_items'] as List<dynamic>? ?? <dynamic>[])
            .map(
              (dynamic item) =>
                  HomeItemModel.fromJson(item as Map<String, dynamic>),
            )
            .toList(growable: false),
  );

  final String description;
  final List<String> galleryImageUrls;
  final List<ProductVariationModel> variations;
  final List<ProductSpecificationModel> specifications;
  final String? originLabel;
  final String? sizeGuideLabel;
  final List<DeliveryOptionModel> deliveryOptions;
  final ProductReviewPreviewModel? reviewPreview;
  final List<HomeItemModel> mostPopularItems;
  final List<HomeItemModel> youMightLikeItems;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'description': description,
    'gallery_image_urls': galleryImageUrls,
    'variations': variations
        .map((ProductVariationModel item) => item.toJson())
        .toList(),
    'specifications': specifications
        .map((ProductSpecificationModel item) => item.toJson())
        .toList(),
    'origin_label': originLabel,
    'size_guide_label': sizeGuideLabel,
    'delivery_options': deliveryOptions
        .map((DeliveryOptionModel item) => item.toJson())
        .toList(),
    'review_preview': reviewPreview?.toJson(),
    'most_popular_items': mostPopularItems
        .map((HomeItemModel item) => item.toJson())
        .toList(),
    'you_might_like_items': youMightLikeItems
        .map((HomeItemModel item) => item.toJson())
        .toList(),
  };

  ProductDetailsEntity toEntity() => ProductDetailsEntity(
    description: description,
    galleryImageUrls: galleryImageUrls,
    variations: variations
        .map((ProductVariationModel variation) => variation.toEntity())
        .toList(),
    specifications: specifications
        .map(
          (ProductSpecificationModel specification) => specification.toEntity(),
        )
        .toList(),
    originLabel: originLabel,
    sizeGuideLabel: sizeGuideLabel,
    deliveryOptions: deliveryOptions
        .map((DeliveryOptionModel option) => option.toEntity())
        .toList(),
    reviewPreview: reviewPreview?.toEntity(),
    mostPopularItems: mostPopularItems
        .map((HomeItemModel item) => item.toEntity())
        .toList(),
    youMightLikeItems: youMightLikeItems
        .map((HomeItemModel item) => item.toEntity())
        .toList(),
  );
}

class HomeItemModel {
  const HomeItemModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.price,
    this.oldPrice,
    this.discountLabel,
    this.categoryIds = const <String>[],
    this.details,
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
    details: json['details'] == null
        ? null
        : ProductDetailsModel.fromJson(json['details'] as Map<String, dynamic>),
  );

  final String id;
  final String title;
  final String imageUrl;
  final double? price;
  final double? oldPrice;
  final String? discountLabel;
  final List<String> categoryIds;
  final ProductDetailsModel? details;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'title': title,
    'image_url': imageUrl,
    'price': price,
    'old_price': oldPrice,
    'discount_label': discountLabel,
    'category_ids': categoryIds,
    'details': details?.toJson(),
  };

  HomeItemEntity toEntity() => HomeItemEntity(
    id: id,
    title: title,
    imageUrl: imageUrl,
    price: price,
    oldPrice: oldPrice,
    discountLabel: discountLabel,
    categoryIds: categoryIds,
    details: details?.toEntity(),
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
