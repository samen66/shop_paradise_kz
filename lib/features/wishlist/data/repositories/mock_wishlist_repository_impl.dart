import '../../domain/entities/wishlist_entities.dart';
import '../../domain/repositories/wishlist_repository.dart';
import '../models/wishlist_models.dart';

class MockWishlistRepositoryImpl implements WishlistRepository {
  const MockWishlistRepositoryImpl();

  @override
  Future<List<WishlistItemEntity>> getWishlistItems() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return kMockWishlistItems
        .map((WishlistItemModel item) => item.toEntity())
        .toList(growable: false);
  }
}
