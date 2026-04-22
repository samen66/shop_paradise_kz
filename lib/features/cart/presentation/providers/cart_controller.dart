import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/cart_entities.dart';
import 'cart_providers.dart';

final cartControllerProvider =
    AsyncNotifierProvider<CartController, CartPageEntity>(CartController.new);

class CartController extends AsyncNotifier<CartPageEntity> {
  @override
  Future<CartPageEntity> build() async {
    return ref.read(getCartUseCaseProvider).call();
  }

  Future<void> refreshCart() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(getCartUseCaseProvider).call());
  }

  Future<void> updateQuantity(String lineId, int quantity) async {
    final CartPageEntity? current = state.valueOrNull;
    if (current == null) {
      return;
    }
    state = AsyncData(
      await ref.read(updateLineQuantityUseCaseProvider).call(lineId, quantity),
    );
  }

  Future<void> removeLine(String lineId) async {
    final CartPageEntity? current = state.valueOrNull;
    if (current == null) {
      return;
    }
    state = AsyncData(
      await ref.read(removeCartLineUseCaseProvider).call(lineId),
    );
  }

  Future<void> applyPromo(String code) async {
    final CartPageEntity? current = state.valueOrNull;
    if (current == null) {
      return;
    }
    state = AsyncData(
      await ref.read(applyPromoCodeUseCaseProvider).call(code),
    );
  }

  Future<void> clearPromo() async {
    final CartPageEntity? current = state.valueOrNull;
    if (current == null) {
      return;
    }
    state = AsyncData(await ref.read(clearPromoUseCaseProvider).call());
  }

  Future<void> setSelectionMode(bool enabled) async {
    final CartPageEntity? current = state.valueOrNull;
    if (current == null) {
      return;
    }
    state = AsyncData(
      await ref.read(setCartSelectionModeUseCaseProvider).call(enabled),
    );
  }

  Future<void> setLineSelected(String lineId, bool selected) async {
    final CartPageEntity? current = state.valueOrNull;
    if (current == null) {
      return;
    }
    state = AsyncData(
      await ref.read(setCartLineSelectedUseCaseProvider).call(lineId, selected),
    );
  }

  Future<void> removeSelectedLines() async {
    final CartPageEntity? current = state.valueOrNull;
    if (current == null) {
      return;
    }
    state = AsyncData(
      await ref.read(removeSelectedCartLinesUseCaseProvider).call(),
    );
  }

  Future<void> setPromoExpanded(bool expanded) async {
    final CartPageEntity? current = state.valueOrNull;
    if (current == null) {
      return;
    }
    state = AsyncData(
      await ref.read(setPromoExpandedUseCaseProvider).call(expanded),
    );
  }

  Future<void> dismissBanner() async {
    final CartPageEntity? current = state.valueOrNull;
    if (current == null) {
      return;
    }
    state = AsyncData(await ref.read(dismissCartBannerUseCaseProvider).call());
  }
}
