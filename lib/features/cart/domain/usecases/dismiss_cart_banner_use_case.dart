import '../entities/cart_entities.dart';
import '../repositories/cart_repository.dart';

class DismissCartBannerUseCase {
  const DismissCartBannerUseCase(this._cartRepository);

  final CartRepository _cartRepository;

  Future<CartPageEntity> call() => _cartRepository.dismissBanner();
}
