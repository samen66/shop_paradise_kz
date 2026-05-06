import '../../home/domain/entities/home_entities.dart';

/// Mock catalog row for the home marketplace grid.
class HomeMarketCatalogProduct {
  const HomeMarketCatalogProduct({
    required this.id,
    required this.image,
    required this.price,
    required this.categoryId,
  });

  final String id;
  final String image;
  final double price;
  /// Mock category key (e.g. groceries); not `all`.
  final String categoryId;

  /// Minimal [HomeItemEntity] for [ProductDetailsPage] (uses fallback details).
  HomeItemEntity toHomeItemEntity({
    required String localizedTitle,
    required String localizedCategoryLabel,
  }) {
    return HomeItemEntity(
      id: id,
      title: localizedTitle,
      imageUrl:
          'https://placehold.co/600x600/png?text=${Uri.encodeComponent(image)}',
      price: price,
      categoryIds: <String>[localizedCategoryLabel],
    );
  }
}
