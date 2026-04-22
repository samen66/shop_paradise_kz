import '../entities/cart_entities.dart';
import '../repositories/cart_repository.dart';

class UpdateLineQuantityUseCase {
  const UpdateLineQuantityUseCase(this._cartRepository);

  final CartRepository _cartRepository;

  Future<CartPageEntity> call(String lineId, int quantity) {
    return _cartRepository.updateLineQuantity(lineId, quantity);
  }
}
