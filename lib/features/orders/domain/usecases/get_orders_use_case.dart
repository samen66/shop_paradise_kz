import '../entities/order_entities.dart';
import '../repositories/orders_repository.dart';

class GetOrdersUseCase {
  const GetOrdersUseCase(this._ordersRepository);

  final OrdersRepository _ordersRepository;

  Future<List<OrderSummaryEntity>> call() {
    return _ordersRepository.getOrders();
  }
}
