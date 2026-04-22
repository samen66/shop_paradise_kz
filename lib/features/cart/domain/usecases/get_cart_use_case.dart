import '../entities/cart_entities.dart';
import '../repositories/cart_repository.dart';

class GetCartUseCase {
  const GetCartUseCase(this._cartRepository);

  final CartRepository _cartRepository;

  Future<CartPageEntity> call() => _cartRepository.getCart();
}
