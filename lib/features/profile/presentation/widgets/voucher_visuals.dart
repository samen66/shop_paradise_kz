import 'package:flutter/material.dart';

import '../../domain/entities/profile_entities.dart';

IconData voucherKindIcon(VoucherVisualKind kind) {
  return switch (kind) {
    VoucherVisualKind.shoppingBag => Icons.shopping_bag_outlined,
    VoucherVisualKind.gift => Icons.card_giftcard_rounded,
    VoucherVisualKind.heart => Icons.favorite_border_rounded,
    VoucherVisualKind.star => Icons.star_outline_rounded,
    VoucherVisualKind.cloud => Icons.cloud_outlined,
    VoucherVisualKind.apparel => Icons.checkroom_outlined,
    VoucherVisualKind.smile => Icons.sentiment_satisfied_alt_outlined,
  };
}
