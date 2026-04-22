import '../entities/cart_entities.dart';
import '../repositories/cart_repository.dart';

class SetPromoExpandedUseCase {
  const SetPromoExpandedUseCase(this._cartRepository);

  final CartRepository _cartRepository;

  Future<CartPageEntity> call(bool expanded) {
    return _cartRepository.setPromoExpanded(expanded);
  }
}
