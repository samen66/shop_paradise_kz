import '../../home/domain/entities/home_entities.dart';

/// Mock catalog row for the home marketplace grid.
class HomeMarketCatalogProduct {
  const HomeMarketCatalogProduct({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.category,
  });

  final String id;
  final String image;
  final String title;
  final double price;
  final String category;

  /// Minimal [HomeItemEntity] for [ProductDetailsPage] (uses fallback details).
  HomeItemEntity toHomeItemEntity() {
    return HomeItemEntity(
      id: id,
      title: title,
      imageUrl:
          'https://placehold.co/600x600/png?text=${Uri.encodeComponent(image)}',
      price: price,
      categoryIds: <String>[category],
    );
  }
}
