import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/wishlist_entities.dart';
import 'wishlist_providers.dart';

final wishlistControllerProvider =
    AsyncNotifierProvider<WishlistController, WishlistPageEntity>(
      WishlistController.new,
    );

class WishlistController extends AsyncNotifier<WishlistPageEntity> {
  @override
  Future<WishlistPageEntity> build() async {
    final List<WishlistItemEntity> items = await ref
        .read(getWishlistItemsUseCaseProvider)
        .call();
    return WishlistPageEntity(items: items);
  }

  Future<void> removeItem(String itemId) async {
    final WishlistPageEntity? currentState = state.valueOrNull;
    if (currentState == null) {
      return;
    }
    final List<WishlistItemEntity> nextItems = currentState.items
        .where((WishlistItemEntity item) => item.id != itemId)
        .toList(growable: false);
    state = AsyncData(WishlistPageEntity(items: nextItems));
  }

  Future<void> clearWishlist() async {
    state = const AsyncData(WishlistPageEntity(items: <WishlistItemEntity>[]));
  }

  Future<void> restoreWishlist() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final List<WishlistItemEntity> items = await ref
          .read(getWishlistItemsUseCaseProvider)
          .call();
      return WishlistPageEntity(items: items);
    });
  }
}
