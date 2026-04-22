enum HomeSectionType {
  categories,
  products,
  newItems,
  flashSale,
  mostPopular,
  justForYou,
  unknown,
}

extension HomeSectionTypeX on HomeSectionType {
  bool get isJustForYou => this == HomeSectionType.justForYou;
}

enum HomeSectionLayout { horizontal, grid2, circles }

class ProductVariationEntity {
  const ProductVariationEntity({
    required this.label,
    required this.value,
    this.previewImageUrls = const <String>[],
  });

  final String label;
  final String value;
  final List<String> previewImageUrls;
}

class ProductSpecificationEntity {
  const ProductSpecificationEntity({
    required this.name,
    this.values = const <String>[],
  });

  final String name;
  final List<String> values;
}

class DeliveryOptionEntity {
  const DeliveryOptionEntity({
    required this.title,
    required this.etaLabel,
    required this.price,
  });

  final String title;
  final String etaLabel;
  final double price;
}

class ProductReviewPreviewEntity {
  const ProductReviewPreviewEntity({
    required this.overallRatingText,
    required this.authorName,
    required this.authorAvatarUrl,
    required this.comment,
    required this.rating,
  });

  final String overallRatingText;
  final String authorName;
  final String authorAvatarUrl;
  final String comment;
  final double rating;
}

class ProductDetailsEntity {
  const ProductDetailsEntity({
    required this.description,
    this.galleryImageUrls = const <String>[],
    this.variations = const <ProductVariationEntity>[],
    this.specifications = const <ProductSpecificationEntity>[],
    this.originLabel,
    this.sizeGuideLabel,
    this.deliveryOptions = const <DeliveryOptionEntity>[],
    this.reviewPreview,
    this.mostPopularItems = const <HomeItemEntity>[],
    this.youMightLikeItems = const <HomeItemEntity>[],
  });

  final String description;
  final List<String> galleryImageUrls;
  final List<ProductVariationEntity> variations;
  final List<ProductSpecificationEntity> specifications;
  final String? originLabel;
  final String? sizeGuideLabel;
  final List<DeliveryOptionEntity> deliveryOptions;
  final ProductReviewPreviewEntity? reviewPreview;
  final List<HomeItemEntity> mostPopularItems;
  final List<HomeItemEntity> youMightLikeItems;
}

class HomeItemEntity {
  const HomeItemEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.price,
    this.oldPrice,
    this.discountLabel,
    this.categoryIds = const <String>[],
    this.details,
  });

  final String id;
  final String title;
  final String imageUrl;
  final double? price;
  final double? oldPrice;
  final String? discountLabel;

  /// Tags for mock/API filtering (OR match when multiple).
  final List<String> categoryIds;
  final ProductDetailsEntity? details;
}

class HomeSectionEntity {
  const HomeSectionEntity({
    required this.type,
    required this.title,
    required this.layout,
    required this.items,
    this.hasMore = false,
    this.nextPage = 1,
  });

  final HomeSectionType type;
  final String title;
  final HomeSectionLayout layout;
  final List<HomeItemEntity> items;
  final bool hasMore;
  final int nextPage;
}

class HomePageEntity {
  const HomePageEntity({required this.sections});

  final List<HomeSectionEntity> sections;
}
