import '../entities/cart_entities.dart';
import '../repositories/cart_repository.dart';

class SetCartLineSelectedUseCase {
  const SetCartLineSelectedUseCase(this._cartRepository);

  final CartRepository _cartRepository;

  Future<CartPageEntity> call(String lineId, bool selected) {
    return _cartRepository.setLineSelected(lineId, selected);
  }
}
