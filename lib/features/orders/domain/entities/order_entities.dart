import 'package:flutter/foundation.dart';

enum OrderStatus { processing, shipped, delivered, cancelled }

@immutable
class OrderSummaryEntity {
  const OrderSummaryEntity({
    required this.id,
    required this.reference,
    required this.placedAt,
    required this.status,
    required this.itemCount,
    required this.total,
  });

  final String id;
  final String reference;
  final DateTime placedAt;
  final OrderStatus status;
  final int itemCount;
  final double total;
}

@immutable
class OrdersPageEntity {
  const OrdersPageEntity({required this.orders});

  final List<OrderSummaryEntity> orders;

  bool get isEmpty => orders.isEmpty;
}
