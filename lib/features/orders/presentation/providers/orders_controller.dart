import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/order_entities.dart';
import 'orders_providers.dart';

final ordersControllerProvider =
    AsyncNotifierProvider<OrdersController, OrdersPageEntity>(
      OrdersController.new,
    );

class OrdersController extends AsyncNotifier<OrdersPageEntity> {
  @override
  Future<OrdersPageEntity> build() async {
    final List<OrderSummaryEntity> orders = await ref
        .read(getOrdersUseCaseProvider)
        .call();
    return OrdersPageEntity(orders: orders);
  }

  Future<void> refreshOrders() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final List<OrderSummaryEntity> orders = await ref
          .read(getOrdersUseCaseProvider)
          .call();
      return OrdersPageEntity(orders: orders);
    });
  }

  void clearOrders() {
    state = const AsyncData(OrdersPageEntity(orders: <OrderSummaryEntity>[]));
  }

  Future<void> restoreDemoOrders() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final List<OrderSummaryEntity> orders = await ref
          .read(getOrdersUseCaseProvider)
          .call();
      return OrdersPageEntity(orders: orders);
    });
  }
}
