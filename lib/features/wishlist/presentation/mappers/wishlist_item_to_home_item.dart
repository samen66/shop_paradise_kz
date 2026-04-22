import '../../../home/domain/entities/home_entities.dart';
import '../../domain/entities/wishlist_entities.dart';

extension WishlistItemToHomeItemMapper on WishlistItemEntity {
  HomeItemEntity toHomeItem() {
    return HomeItemEntity(
      id: id,
      title: '$brand · $title',
      imageUrl: imageUrl,
      price: currentPrice,
      oldPrice: originalPrice,
      discountLabel: discountLabel,
    );
  }
}
