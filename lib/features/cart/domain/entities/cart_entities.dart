import 'package:flutter/foundation.dart';

/// Frames in Figma file `rpzgXOHpVC4vS6Yu55DpnL` (Shoppe) for the cart screen.
/// MCP was unavailable at build time; each value maps to the node-id order
/// from `0-7209` through `0-5461` for design QA when Figma access returns.
enum CartFigmaScenario {
  /// 0-7209 — empty cart, primary CTA to shop.
  node7209Empty,

  /// 0-7085 — default cart with line items and enabled checkout.
  node7085Default,

  /// 0-6969 — selection mode; bulk actions (e.g. delete selected).
  node6969SelectMode,

  /// 0-6830 — promo / coupon field expanded or focused.
  node6830PromoInput,

  /// 0-6638 — valid promo applied; summary shows discount.
  node6638PromoApplied,

  /// 0-6503 — positive inline feedback (e.g. coupon applied toast).
  node6503BannerSuccess,

  /// 0-6289 — line item unavailable / out of stock treatment.
  node6289OutOfStock,

  /// 0-6124 — error inline feedback.
  node6124BannerError,

  /// 0-5936 — free-shipping or threshold messaging.
  node5936FreeShippingHint,

  /// 0-5767 — checkout disabled (e.g. minimum not met).
  node5767CheckoutDisabled,

  /// 0-5612 — denser cart (multiple lines).
  node5612MultiLine,

  /// 0-5461 — summary includes tax or extra fee row.
  node5461TaxRow,
}

enum CartLineAvailability { inStock, outOfStock }

enum CartBannerStyle { success, error, info }

@immutable
class CartLineItemEntity {
  const CartLineItemEntity({
    required this.id,
    required this.title,
    required this.variantLabel,
    required this.imageUrl,
    required this.unitPrice,
    required this.quantity,
    required this.availability,
    this.originalPrice,
    this.discountLabel,
    this.selected = true,
  });

  final String id;
  final String title;
  final String variantLabel;
  final String imageUrl;
  final double unitPrice;
  final double? originalPrice;
  final String? discountLabel;
  final int quantity;
  final CartLineAvailability availability;
  final bool selected;

  bool get isOutOfStock => availability == CartLineAvailability.outOfStock;

  double get lineTotal => unitPrice * quantity;

  CartLineItemEntity copyWith({
    String? id,
    String? title,
    String? variantLabel,
    String? imageUrl,
    double? unitPrice,
    double? originalPrice,
    String? discountLabel,
    int? quantity,
    CartLineAvailability? availability,
    bool? selected,
  }) {
    return CartLineItemEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      variantLabel: variantLabel ?? this.variantLabel,
      imageUrl: imageUrl ?? this.imageUrl,
      unitPrice: unitPrice ?? this.unitPrice,
      originalPrice: originalPrice ?? this.originalPrice,
      discountLabel: discountLabel ?? this.discountLabel,
      quantity: quantity ?? this.quantity,
      availability: availability ?? this.availability,
      selected: selected ?? this.selected,
    );
  }
}

@immutable
class CartSummaryEntity {
  const CartSummaryEntity({
    required this.subtotal,
    required this.shipping,
    required this.total,
    this.tax,
    this.discount,
    this.shippingLabel = 'Shipping',
    this.freeShippingHint,
    this.amountUntilFreeShipping,
    this.checkoutBlockedReason,
  });

  final double subtotal;
  final double shipping;
  final double? tax;
  final double? discount;
  final double total;
  final String shippingLabel;
  final String? freeShippingHint;
  final double? amountUntilFreeShipping;
  final String? checkoutBlockedReason;
}

@immutable
class CartPromoEntity {
  const CartPromoEntity({
    this.draftCode = '',
    this.appliedCode,
    this.discountAmount = 0,
    this.errorMessage,
    this.expanded = false,
  });

  final String draftCode;
  final String? appliedCode;
  final double discountAmount;
  final String? errorMessage;
  final bool expanded;

  bool get hasApplied => appliedCode != null && appliedCode!.isNotEmpty;

  CartPromoEntity copyWith({
    String? draftCode,
    String? appliedCode,
    double? discountAmount,
    String? errorMessage,
    bool? expanded,
    bool clearApplied = false,
    bool clearError = false,
  }) {
    return CartPromoEntity(
      draftCode: draftCode ?? this.draftCode,
      appliedCode: clearApplied ? null : (appliedCode ?? this.appliedCode),
      discountAmount: clearApplied ? 0 : (discountAmount ?? this.discountAmount),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      expanded: expanded ?? this.expanded,
    );
  }
}

@immutable
class CartPageEntity {
  const CartPageEntity({
    required this.lines,
    required this.summary,
    required this.promo,
    this.selectionMode = false,
    this.bannerMessage,
    this.bannerStyle,
    this.checkoutEnabled = true,
    this.showPromoExpanded = false,
  });

  final List<CartLineItemEntity> lines;
  final CartSummaryEntity summary;
  final CartPromoEntity promo;
  final bool selectionMode;
  final String? bannerMessage;
  final CartBannerStyle? bannerStyle;
  final bool checkoutEnabled;
  final bool showPromoExpanded;

  bool get isEmpty => lines.isEmpty;

  int get selectedCount => lines.where((CartLineItemEntity l) => l.selected).length;

  CartPageEntity copyWith({
    List<CartLineItemEntity>? lines,
    CartSummaryEntity? summary,
    CartPromoEntity? promo,
    bool? selectionMode,
    String? bannerMessage,
    CartBannerStyle? bannerStyle,
    bool clearBanner = false,
    bool? checkoutEnabled,
    bool? showPromoExpanded,
  }) {
    return CartPageEntity(
      lines: lines ?? this.lines,
      summary: summary ?? this.summary,
      promo: promo ?? this.promo,
      selectionMode: selectionMode ?? this.selectionMode,
      bannerMessage: clearBanner ? null : (bannerMessage ?? this.bannerMessage),
      bannerStyle: clearBanner ? null : (bannerStyle ?? this.bannerStyle),
      checkoutEnabled: checkoutEnabled ?? this.checkoutEnabled,
      showPromoExpanded: showPromoExpanded ?? this.showPromoExpanded,
    );
  }
}
