import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shop_paradise_kz/features/wishlist/domain/entities/wishlist_entities.dart';
import 'package:shop_paradise_kz/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:shop_paradise_kz/features/wishlist/domain/usecases/get_wishlist_items_use_case.dart';
import 'package:shop_paradise_kz/features/wishlist/presentation/providers/wishlist_controller.dart';
import 'package:shop_paradise_kz/features/wishlist/presentation/providers/wishlist_providers.dart';

void main() {
  test('Wishlist controller loads and clears items', () async {
    final ProviderContainer container = ProviderContainer(
      overrides: <Override>[
        getWishlistItemsUseCaseProvider.overrideWithValue(
          GetWishlistItemsUseCase(_FakeWishlistRepository()),
        ),
      ],
    );
    addTearDown(container.dispose);

    await container.read(wishlistControllerProvider.future);
    final WishlistPageEntity initialState = container
        .read(wishlistControllerProvider)
        .requireValue;
    expect(initialState.items.length, 2);

    await container.read(wishlistControllerProvider.notifier).removeItem('1');
    final WishlistPageEntity afterRemove = container
        .read(wishlistControllerProvider)
        .requireValue;
    expect(afterRemove.items.length, 1);

    await container.read(wishlistControllerProvider.notifier).clearWishlist();
    final WishlistPageEntity afterClear = container
        .read(wishlistControllerProvider)
        .requireValue;
    expect(afterClear.isEmpty, true);
  });
}

class _FakeWishlistRepository implements WishlistRepository {
  @override
  Future<List<WishlistItemEntity>> getWishlistItems() async {
    return const <WishlistItemEntity>[
      WishlistItemEntity(
        id: '1',
        title: 'A',
        brand: 'Brand A',
        imageUrl: 'x',
        currentPrice: 10,
        availability: WishlistItemAvailability.inStock,
      ),
      WishlistItemEntity(
        id: '2',
        title: 'B',
        brand: 'Brand B',
        imageUrl: 'x',
        currentPrice: 20,
        availability: WishlistItemAvailability.limited,
      ),
    ];
  }
}
