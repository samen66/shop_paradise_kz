import '../entities/wishlist_entities.dart';

abstract class WishlistRepository {
  Future<List<WishlistItemEntity>> getWishlistItems();
}
