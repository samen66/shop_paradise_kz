import 'package:flutter_test/flutter_test.dart';
import 'package:shop_paradise_kz/features/cart/domain/entities/cart_entities.dart';
import 'package:shop_paradise_kz/features/cart/domain/repositories/cart_repository.dart';
import 'package:shop_paradise_kz/features/cart/domain/usecases/get_cart_use_case.dart';

void main() {
  test('returns cart from repository', () async {
    final CartPageEntity expected = CartPageEntity(
      lines: <CartLineItemEntity>[],
      summary: const CartSummaryEntity(
        subtotal: 0,
        shipping: 0,
        total: 0,
      ),
      promo: const CartPromoEntity(),
    );
    final GetCartUseCase useCase = GetCartUseCase(_FakeCartRepository(expected));
    final CartPageEntity actual = await useCase.call();
    expect(actual.isEmpty, isTrue);
    expect(actual.summary.total, 0);
  });

  test('propagates repository errors', () async {
    final GetCartUseCase useCase = GetCartUseCase(_ThrowingCartRepository());
    expect(useCase.call(), throwsA(isA<Exception>()));
  });
}

class _FakeCartRepository implements CartRepository {
  _FakeCartRepository(this._page);

  final CartPageEntity _page;

  @override
  Future<CartPageEntity> applyPromoCode(String code) async => _page;

  @override
  Future<CartPageEntity> clearPromo() async => _page;

  @override
  Future<CartPageEntity> dismissBanner() async => _page;

  @override
  Future<CartPageEntity> getCart() async => _page;

  @override
  Future<CartPageEntity> removeLine(String lineId) async => _page;

  @override
  Future<CartPageEntity> removeSelectedLines() async => _page;

  @override
  Future<CartPageEntity> setLineSelected(String lineId, bool selected) async =>
      _page;

  @override
  Future<CartPageEntity> setPromoExpanded(bool expanded) async => _page;

  @override
  Future<CartPageEntity> setSelectionMode(bool enabled) async => _page;

  @override
  Future<CartPageEntity> updateLineQuantity(String lineId, int quantity) async =>
      _page;
}

class _ThrowingCartRepository implements CartRepository {
  @override
  Future<CartPageEntity> applyPromoCode(String code) async =>
      throw Exception('fail');

  @override
  Future<CartPageEntity> clearPromo() async => throw Exception('fail');

  @override
  Future<CartPageEntity> dismissBanner() async => throw Exception('fail');

  @override
  Future<CartPageEntity> getCart() async => throw Exception('network');

  @override
  Future<CartPageEntity> removeLine(String lineId) async =>
      throw Exception('fail');

  @override
  Future<CartPageEntity> removeSelectedLines() async =>
      throw Exception('fail');

  @override
  Future<CartPageEntity> setLineSelected(String lineId, bool selected) async =>
      throw Exception('fail');

  @override
  Future<CartPageEntity> setPromoExpanded(bool expanded) async =>
      throw Exception('fail');

  @override
  Future<CartPageEntity> setSelectionMode(bool enabled) async =>
      throw Exception('fail');

  @override
  Future<CartPageEntity> updateLineQuantity(String lineId, int quantity) async =>
      throw Exception('fail');
}
