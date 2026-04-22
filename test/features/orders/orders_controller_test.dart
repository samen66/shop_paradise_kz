import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shop_paradise_kz/features/orders/domain/entities/order_entities.dart';
import 'package:shop_paradise_kz/features/orders/domain/repositories/orders_repository.dart';
import 'package:shop_paradise_kz/features/orders/presentation/providers/orders_controller.dart';
import 'package:shop_paradise_kz/features/orders/presentation/providers/orders_providers.dart';

void main() {
  test('Orders controller loads list from repository', () async {
    final _FakeOrdersRepository repo = _FakeOrdersRepository();
    final ProviderContainer container = ProviderContainer(
      overrides: <Override>[
        ordersRepositoryProvider.overrideWithValue(repo),
      ],
    );
    addTearDown(container.dispose);

    await container.read(ordersControllerProvider.future);
    final OrdersPageEntity loaded =
        container.read(ordersControllerProvider).requireValue;
    expect(loaded.orders.length, 1);
    expect(loaded.orders.single.reference, '#TEST-1');
  });

  test('clearOrders then restoreDemoOrders round-trips', () async {
    final _FakeOrdersRepository repo = _FakeOrdersRepository();
    final ProviderContainer container = ProviderContainer(
      overrides: <Override>[
        ordersRepositoryProvider.overrideWithValue(repo),
      ],
    );
    addTearDown(container.dispose);

    await container.read(ordersControllerProvider.future);
    expect(
      container.read(ordersControllerProvider).requireValue.isEmpty,
      false,
    );

    container.read(ordersControllerProvider.notifier).clearOrders();
    expect(
      container.read(ordersControllerProvider).requireValue.isEmpty,
      true,
    );

    await container.read(ordersControllerProvider.notifier).restoreDemoOrders();
    final OrdersPageEntity restored =
        container.read(ordersControllerProvider).requireValue;
    expect(restored.orders.length, 1);
  });
}

class _FakeOrdersRepository implements OrdersRepository {
  @override
  Future<List<OrderSummaryEntity>> getOrders() async {
    return <OrderSummaryEntity>[
      OrderSummaryEntity(
        id: 't1',
        reference: '#TEST-1',
        placedAt: DateTime(2026, 1, 1),
        status: OrderStatus.delivered,
        itemCount: 1,
        total: 100,
      ),
    ];
  }
}
