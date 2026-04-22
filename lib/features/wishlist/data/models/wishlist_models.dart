import '../../domain/entities/wishlist_entities.dart';

class WishlistItemModel {
  const WishlistItemModel({
    required this.id,
    required this.title,
    required this.brand,
    required this.imageUrl,
    required this.currentPrice,
    required this.availability,
    this.originalPrice,
    this.discountLabel,
  });

  final String id;
  final String title;
  final String brand;
  final String imageUrl;
  final double currentPrice;
  final double? originalPrice;
  final String? discountLabel;
  final WishlistItemAvailability availability;

  WishlistItemEntity toEntity() {
    return WishlistItemEntity(
      id: id,
      title: title,
      brand: brand,
      imageUrl: imageUrl,
      currentPrice: currentPrice,
      originalPrice: originalPrice,
      discountLabel: discountLabel,
      availability: availability,
    );
  }
}

const List<WishlistItemModel> kMockWishlistItems = <WishlistItemModel>[
  WishlistItemModel(
    id: 'wl_001',
    title: 'Classic Cotton Jacket',
    brand: 'Mango Boy',
    imageUrl:
        'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=800',
    currentPrice: 46.0,
    originalPrice: 64.0,
    discountLabel: '30% OFF',
    availability: WishlistItemAvailability.inStock,
  ),
  WishlistItemModel(
    id: 'wl_002',
    title: 'Running Sneakers',
    brand: 'Urban Move',
    imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=800',
    currentPrice: 88.0,
    availability: WishlistItemAvailability.limited,
  ),
  WishlistItemModel(
    id: 'wl_003',
    title: 'Soft Knit Hoodie',
    brand: 'NN Collective',
    imageUrl:
        'https://images.unsplash.com/photo-1576871337632-b9aef4c17ab9?w=800',
    currentPrice: 52.0,
    originalPrice: 70.0,
    discountLabel: 'NEW PRICE',
    availability: WishlistItemAvailability.outOfStock,
  ),
];
