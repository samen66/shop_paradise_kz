import 'package:flutter/foundation.dart';

import '../../cart/domain/entities/cart_entities.dart';

/// Design uses comma decimals, e.g. `$34,00`.
String formatPaymentMoney(double value) {
  final String s = value.toStringAsFixed(2);
  return '\$${s.replaceAll('.', ',')}';
}

@immutable
class PaymentLineSnapshot {
  const PaymentLineSnapshot({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.quantity,
    required this.lineTotal,
  });

  final String id;
  final String title;
  final String imageUrl;
  final int quantity;
  final double lineTotal;
}

@immutable
class PaymentCheckoutArgs {
  const PaymentCheckoutArgs({
    required this.lines,
    required this.merchandiseSubtotal,
    this.cartDiscountAmount = 0,
    this.cartDiscountLabel,
  });

  final List<PaymentLineSnapshot> lines;
  final double merchandiseSubtotal;
  final double cartDiscountAmount;
  final String? cartDiscountLabel;

  factory PaymentCheckoutArgs.fromCart(CartPageEntity cart) {
    final List<PaymentLineSnapshot> lines = cart.lines
        .map(
          (CartLineItemEntity l) => PaymentLineSnapshot(
            id: l.id,
            title: l.title,
            imageUrl: l.imageUrl,
            quantity: l.quantity,
            lineTotal: l.lineTotal,
          ),
        )
        .toList(growable: false);
    final double subtotal = cart.lines.fold<double>(
      0,
      (double s, CartLineItemEntity l) => s + l.lineTotal,
    );
    return PaymentCheckoutArgs(
      lines: lines,
      merchandiseSubtotal: subtotal,
      cartDiscountAmount: cart.promo.hasApplied ? cart.promo.discountAmount : 0,
      cartDiscountLabel: cart.promo.hasApplied ? cart.promo.appliedCode : null,
    );
  }
}
