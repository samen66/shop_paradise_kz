import '../../domain/entities/order_entities.dart';
import '../../domain/repositories/orders_repository.dart';

class MockOrdersRepositoryImpl implements OrdersRepository {
  @override
  Future<List<OrderSummaryEntity>> getOrders() async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    return _demoOrders;
  }

  static final List<OrderSummaryEntity> _demoOrders = <OrderSummaryEntity>[
    OrderSummaryEntity(
      id: 'ord_1',
      reference: '#SP-24089',
      placedAt: DateTime(2026, 3, 14, 11, 30),
      status: OrderStatus.delivered,
      itemCount: 2,
      total: 42_990,
    ),
    OrderSummaryEntity(
      id: 'ord_2',
      reference: '#SP-24012',
      placedAt: DateTime(2026, 4, 2, 9, 15),
      status: OrderStatus.shipped,
      itemCount: 1,
      total: 18_500,
    ),
    OrderSummaryEntity(
      id: 'ord_3',
      reference: '#SP-23901',
      placedAt: DateTime(2026, 4, 18, 16, 45),
      status: OrderStatus.processing,
      itemCount: 4,
      total: 96_200,
    ),
  ];
}
