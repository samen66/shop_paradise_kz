import 'package:flutter/foundation.dart';

enum WishlistItemAvailability { inStock, limited, outOfStock }

@immutable
class WishlistItemEntity {
  const WishlistItemEntity({
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
}

@immutable
class WishlistPageEntity {
  const WishlistPageEntity({required this.items});

  final List<WishlistItemEntity> items;

  bool get isEmpty => items.isEmpty;
}
