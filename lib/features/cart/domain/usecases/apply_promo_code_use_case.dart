import '../entities/cart_entities.dart';
import '../repositories/cart_repository.dart';

class ApplyPromoCodeUseCase {
  const ApplyPromoCodeUseCase(this._cartRepository);

  final CartRepository _cartRepository;

  Future<CartPageEntity> call(String code) {
    return _cartRepository.applyPromoCode(code);
  }
}
