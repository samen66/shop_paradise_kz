import '../entities/cart_entities.dart';
import '../repositories/cart_repository.dart';

class SetCartSelectionModeUseCase {
  const SetCartSelectionModeUseCase(this._cartRepository);

  final CartRepository _cartRepository;

  Future<CartPageEntity> call(bool enabled) {
    return _cartRepository.setSelectionMode(enabled);
  }
}
