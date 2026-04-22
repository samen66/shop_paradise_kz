import '../entities/wishlist_entities.dart';
import '../repositories/wishlist_repository.dart';

class GetWishlistItemsUseCase {
  const GetWishlistItemsUseCase(this._wishlistRepository);

  final WishlistRepository _wishlistRepository;

  Future<List<WishlistItemEntity>> call() {
    return _wishlistRepository.getWishlistItems();
  }
}
