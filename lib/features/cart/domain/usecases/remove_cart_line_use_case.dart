import '../entities/cart_entities.dart';
import '../repositories/cart_repository.dart';

class RemoveCartLineUseCase {
  const RemoveCartLineUseCase(this._cartRepository);

  final CartRepository _cartRepository;

  Future<CartPageEntity> call(String lineId) {
    return _cartRepository.removeLine(lineId);
  }
}
