import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shop_paradise_kz/features/cart/data/repositories/mock_cart_repository_impl.dart';
import 'package:shop_paradise_kz/features/cart/domain/entities/cart_entities.dart';
import 'package:shop_paradise_kz/features/cart/domain/repositories/cart_repository.dart';
import 'package:shop_paradise_kz/features/cart/presentation/providers/cart_controller.dart';
import 'package:shop_paradise_kz/features/cart/presentation/providers/cart_providers.dart';

void main() {
  test('Cart controller loads default cart and updates quantity', () async {
    final _SequentialCartRepository repo = _SequentialCartRepository();
    final ProviderContainer container = ProviderContainer(
      overrides: <Override>[
        cartRepositoryProvider.overrideWithValue(repo),
      ],
    );
    addTearDown(container.dispose);

    await container.read(cartControllerProvider.future);
    final CartPageEntity loaded = container.read(cartControllerProvider).requireValue;
    expect(loaded.lines.length, 1);
    expect(loaded.lines.first.quantity, 1);

    await container
        .read(cartControllerProvider.notifier)
        .updateQuantity('1', 3);
    final CartPageEntity updated = container.read(cartControllerProvider).requireValue;
    expect(updated.lines.first.quantity, 3);
  });

  test('Figma presets expose distinct cart states', () {
    final CartPageEntity empty =
        MockCartRepositoryImpl.figmaPreset(CartFigmaScenario.node7209Empty);
    expect(empty.isEmpty, true);

    final CartPageEntity select =
        MockCartRepositoryImpl.figmaPreset(CartFigmaScenario.node6969SelectMode);
    expect(select.selectionMode, true);

    final CartPageEntity tax =
        MockCartRepositoryImpl.figmaPreset(CartFigmaScenario.node5461TaxRow);
    expect(tax.summary.tax, isNotNull);
  });
}

/// Returns a minimal one-line cart then applies quantity updates in memory.
class _SequentialCartRepository implements CartRepository {
  CartPageEntity _page = CartPageEntity(
    lines: const <CartLineItemEntity>[
      CartLineItemEntity(
        id: '1',
        title: 'Test',
        variantLabel: 'M',
        imageUrl: 'https://example.com/x.jpg',
        unitPrice: 10,
        quantity: 1,
        availability: CartLineAvailability.inStock,
      ),
    ],
    summary: const CartSummaryEntity(
      subtotal: 10,
      shipping: 0,
      total: 10,
    ),
    promo: const CartPromoEntity(),
  );

  @override
  Future<CartPageEntity> getCart() async => _page;

  @override
  Future<CartPageEntity> updateLineQuantity(String lineId, int quantity) async {
    _page = _page.copyWith(
      lines: _page.lines
          .map(
            (CartLineItemEntity l) =>
                l.id == lineId ? l.copyWith(quantity: quantity) : l,
          )
          .toList(growable: false),
    );
    return _page;
  }

  @override
  Future<CartPageEntity> removeLine(String lineId) async {
    _page = _page.copyWith(
      lines: _page.lines
          .where((CartLineItemEntity l) => l.id != lineId)
          .toList(growable: false),
    );
    return _page;
  }

  @override
  Future<CartPageEntity> applyPromoCode(String code) async => _page;

  @override
  Future<CartPageEntity> clearPromo() async => _page;

  @override
  Future<CartPageEntity> setSelectionMode(bool enabled) async => _page;

  @override
  Future<CartPageEntity> setLineSelected(String lineId, bool selected) async =>
      _page;

  @override
  Future<CartPageEntity> removeSelectedLines() async => _page;

  @override
  Future<CartPageEntity> setPromoExpanded(bool expanded) async => _page;

  @override
  Future<CartPageEntity> dismissBanner() async => _page;
}
