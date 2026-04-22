import '../entities/cart_entities.dart';

abstract class CartRepository {
  Future<CartPageEntity> getCart();

  Future<CartPageEntity> updateLineQuantity(String lineId, int quantity);

  Future<CartPageEntity> removeLine(String lineId);

  Future<CartPageEntity> applyPromoCode(String code);

  Future<CartPageEntity> clearPromo();

  Future<CartPageEntity> setSelectionMode(bool enabled);

  Future<CartPageEntity> setLineSelected(String lineId, bool selected);

  Future<CartPageEntity> removeSelectedLines();

  Future<CartPageEntity> setPromoExpanded(bool expanded);

  Future<CartPageEntity> dismissBanner();
}
