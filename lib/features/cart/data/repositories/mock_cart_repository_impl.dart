import '../../domain/entities/cart_entities.dart';
import '../../domain/repositories/cart_repository.dart';

/// Mock cart with in-memory mutations. Use [figmaPreset] for static snapshots
/// matching each Figma frame (node IDs documented on [CartFigmaScenario]).
class MockCartRepositoryImpl implements CartRepository {
  MockCartRepositoryImpl({CartPageEntity? initial})
    : _page = initial ?? figmaPreset(CartFigmaScenario.node7085Default);

  CartPageEntity _page;

  static const String _validPromoCode = 'SAVE10';
  static const double _promoDiscount = 10;
  static const double _freeShippingThreshold = 120;
  static const double _standardShipping = 8;

  /// Static snapshot for tests / design QA — does not include live mutations.
  static CartPageEntity figmaPreset(CartFigmaScenario scenario) {
    switch (scenario) {
      case CartFigmaScenario.node7209Empty:
        return _empty();
      case CartFigmaScenario.node7085Default:
        return _twoItems(
          selectionMode: false,
          promo: const CartPromoEntity(),
          checkoutEnabled: true,
        );
      case CartFigmaScenario.node6969SelectMode:
        return _twoItems(
          selectionMode: true,
          promo: const CartPromoEntity(),
          checkoutEnabled: true,
        );
      case CartFigmaScenario.node6830PromoInput:
        return _twoItems(
          selectionMode: false,
          promo: const CartPromoEntity(expanded: true, draftCode: ''),
          showPromoExpanded: true,
          checkoutEnabled: true,
        );
      case CartFigmaScenario.node6638PromoApplied:
        return _twoItems(
          selectionMode: false,
          promo: const CartPromoEntity(
            appliedCode: _validPromoCode,
            discountAmount: _promoDiscount,
          ),
          checkoutEnabled: true,
        );
      case CartFigmaScenario.node6503BannerSuccess:
        return _twoItems(
          selectionMode: false,
          promo: const CartPromoEntity(
            appliedCode: _validPromoCode,
            discountAmount: _promoDiscount,
          ),
          bannerMessage: 'Promo code applied',
          bannerStyle: CartBannerStyle.success,
          checkoutEnabled: true,
        );
      case CartFigmaScenario.node6289OutOfStock:
        final List<CartLineItemEntity> oosLines = <CartLineItemEntity>[
          _lineA,
          _lineB.copyWith(
            id: 'cart_oos',
            availability: CartLineAvailability.outOfStock,
            quantity: 1,
          ),
        ];
        return CartPageEntity(
          lines: oosLines,
          summary: _summaryFor(
            lines: oosLines,
            discount: 0,
            includeTax: false,
            checkoutBlockedReason: null,
          ),
          promo: const CartPromoEntity(),
          checkoutEnabled: true,
        );
      case CartFigmaScenario.node6124BannerError:
        return _twoItems(
          selectionMode: false,
          promo: const CartPromoEntity(errorMessage: 'Invalid code'),
          bannerMessage: 'Something went wrong. Try again.',
          bannerStyle: CartBannerStyle.error,
          checkoutEnabled: true,
        );
      case CartFigmaScenario.node5936FreeShippingHint:
        final List<CartLineItemEntity> lines = <CartLineItemEntity>[
          _lineA.copyWith(quantity: 1),
        ];
        return CartPageEntity(
          lines: lines,
          summary: _summaryFor(
            lines: lines,
            discount: 0,
            includeTax: false,
            checkoutBlockedReason: null,
            freeShippingHint: 'Add more to unlock free shipping',
            amountUntilFreeShipping: 45,
          ),
          promo: const CartPromoEntity(),
          checkoutEnabled: true,
        );
      case CartFigmaScenario.node5767CheckoutDisabled:
        final List<CartLineItemEntity> lines = <CartLineItemEntity>[
          _lineA.copyWith(quantity: 1, unitPrice: 12),
        ];
        return CartPageEntity(
          lines: lines,
          summary: _summaryFor(
            lines: lines,
            discount: 0,
            includeTax: false,
            checkoutBlockedReason: 'Minimum order \$25',
          ),
          promo: const CartPromoEntity(),
          checkoutEnabled: false,
        );
      case CartFigmaScenario.node5612MultiLine:
        return CartPageEntity(
          lines: <CartLineItemEntity>[
            _lineA,
            _lineB,
            _lineC,
          ],
          summary: _summaryFor(
            lines: <CartLineItemEntity>[_lineA, _lineB, _lineC],
            discount: 0,
            includeTax: false,
            checkoutBlockedReason: null,
          ),
          promo: const CartPromoEntity(),
          checkoutEnabled: true,
        );
      case CartFigmaScenario.node5461TaxRow:
        return _twoItems(
          selectionMode: false,
          promo: const CartPromoEntity(),
          checkoutEnabled: true,
          includeTax: true,
        );
    }
  }

  static CartPageEntity _empty() {
    return CartPageEntity(
      lines: const <CartLineItemEntity>[],
      summary: const CartSummaryEntity(
        subtotal: 0,
        shipping: 0,
        total: 0,
      ),
      promo: const CartPromoEntity(),
      checkoutEnabled: false,
    );
  }

  static CartPageEntity _twoItems({
    required bool selectionMode,
    required CartPromoEntity promo,
    required bool checkoutEnabled,
    bool showPromoExpanded = false,
    String? bannerMessage,
    CartBannerStyle? bannerStyle,
    bool includeTax = false,
  }) {
    final List<CartLineItemEntity> lines = <CartLineItemEntity>[
      _lineA,
      _lineB,
    ];
    return CartPageEntity(
      lines: lines,
      summary: _summaryFor(
        lines: lines,
        discount: promo.discountAmount,
        includeTax: includeTax,
        checkoutBlockedReason: checkoutEnabled ? null : 'Minimum order \$25',
      ),
      promo: promo,
      selectionMode: selectionMode,
      bannerMessage: bannerMessage,
      bannerStyle: bannerStyle,
      checkoutEnabled: checkoutEnabled,
      showPromoExpanded: showPromoExpanded,
    );
  }

  static const CartLineItemEntity _lineA = CartLineItemEntity(
    id: 'cart_001',
    title: 'Classic Cotton Jacket',
    variantLabel: 'Size M · Black',
    imageUrl:
        'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=800',
    unitPrice: 46,
    originalPrice: 64,
    discountLabel: '30% OFF',
    quantity: 1,
    availability: CartLineAvailability.inStock,
    selected: true,
  );

  static const CartLineItemEntity _lineB = CartLineItemEntity(
    id: 'cart_002',
    title: 'Running Sneakers',
    variantLabel: 'Size 42 · White',
    imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=800',
    unitPrice: 88,
    quantity: 1,
    availability: CartLineAvailability.inStock,
    selected: true,
  );

  static const CartLineItemEntity _lineC = CartLineItemEntity(
    id: 'cart_003',
    title: 'Soft Knit Hoodie',
    variantLabel: 'Size L · Grey',
    imageUrl:
        'https://images.unsplash.com/photo-1576871337632-b9aef4c17ab9?w=800',
    unitPrice: 52,
    quantity: 2,
    availability: CartLineAvailability.inStock,
    selected: true,
  );

  static CartSummaryEntity _summaryFor({
    required List<CartLineItemEntity> lines,
    required double discount,
    required bool includeTax,
    required String? checkoutBlockedReason,
    String? freeShippingHint,
    double? amountUntilFreeShipping,
  }) {
    final double subtotal = lines.fold<double>(
      0,
      (double sum, CartLineItemEntity l) => sum + l.lineTotal,
    );
    final double afterDiscount = (subtotal - discount).clamp(0, double.infinity);
    final bool freeShip = subtotal >= _freeShippingThreshold;
    final double shipping = lines.isEmpty
        ? 0
        : freeShip
        ? 0
        : _standardShipping;
    final double? tax = includeTax
        ? double.parse((afterDiscount * 0.08).toStringAsFixed(2))
        : null;
    final double total =
        afterDiscount + shipping + (tax ?? 0);
    return CartSummaryEntity(
      subtotal: subtotal,
      shipping: shipping,
      discount: discount > 0 ? discount : null,
      tax: tax,
      total: total,
      shippingLabel: freeShip ? 'Free shipping' : 'Shipping',
      freeShippingHint: freeShippingHint,
      amountUntilFreeShipping: amountUntilFreeShipping,
      checkoutBlockedReason: checkoutBlockedReason,
    );
  }

  CartPageEntity _withSummary(CartPageEntity page) {
    return page.copyWith(
      summary: _summaryFor(
        lines: page.lines,
        discount: page.promo.discountAmount,
        includeTax: page.summary.tax != null,
        checkoutBlockedReason: page.summary.checkoutBlockedReason,
        freeShippingHint: page.summary.freeShippingHint,
        amountUntilFreeShipping: page.summary.amountUntilFreeShipping,
      ),
    );
  }

  @override
  Future<CartPageEntity> getCart() async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    return _page;
  }

  @override
  Future<CartPageEntity> updateLineQuantity(
    String lineId,
    int quantity,
  ) async {
    final List<CartLineItemEntity> nextLines = _page.lines
        .map((CartLineItemEntity l) {
          if (l.id != lineId) {
            return l;
          }
          if (l.isOutOfStock) {
            return l;
          }
          final int q = quantity.clamp(1, 99);
          return l.copyWith(quantity: q);
        })
        .toList(growable: false);
    _page = _withSummary(_page.copyWith(lines: nextLines));
    return _page;
  }

  @override
  Future<CartPageEntity> removeLine(String lineId) async {
    final List<CartLineItemEntity> nextLines = _page.lines
        .where((CartLineItemEntity l) => l.id != lineId)
        .toList(growable: false);
    _page = _withSummary(
      _page.copyWith(
        lines: nextLines,
        checkoutEnabled: nextLines.isEmpty ? false : true,
      ),
    );
    return _page;
  }

  @override
  Future<CartPageEntity> applyPromoCode(String code) async {
    final String trimmed = code.trim().toUpperCase();
    if (trimmed.isEmpty) {
      _page = _withSummary(
        _page.copyWith(
          promo: _page.promo.copyWith(
            errorMessage: 'Enter a code',
            clearApplied: true,
          ),
        ),
      );
      return _page;
    }
    if (trimmed == _validPromoCode) {
      _page = _withSummary(
        _page.copyWith(
          promo: CartPromoEntity(
            draftCode: '',
            appliedCode: _validPromoCode,
            discountAmount: _promoDiscount,
            expanded: _page.promo.expanded,
          ),
          bannerMessage: 'Promo code applied',
          bannerStyle: CartBannerStyle.success,
        ),
      );
    } else {
      _page = _withSummary(
        _page.copyWith(
          promo: _page.promo.copyWith(
            errorMessage: 'Invalid code',
            clearApplied: true,
          ),
          bannerMessage: 'Could not apply promo',
          bannerStyle: CartBannerStyle.error,
        ),
      );
    }
    return _page;
  }

  @override
  Future<CartPageEntity> clearPromo() async {
    _page = _withSummary(
      _page.copyWith(
        promo: _page.promo.copyWith(clearApplied: true, clearError: true),
      ),
    );
    return _page;
  }

  @override
  Future<CartPageEntity> setSelectionMode(bool enabled) async {
    final List<CartLineItemEntity> nextLines = _page.lines
        .map((CartLineItemEntity l) => l.copyWith(selected: true))
        .toList(growable: false);
    _page = _page.copyWith(selectionMode: enabled, lines: nextLines);
    return _page;
  }

  @override
  Future<CartPageEntity> setLineSelected(String lineId, bool selected) async {
    final List<CartLineItemEntity> nextLines = _page.lines
        .map(
          (CartLineItemEntity l) =>
              l.id == lineId ? l.copyWith(selected: selected) : l,
        )
        .toList(growable: false);
    _page = _withSummary(_page.copyWith(lines: nextLines));
    return _page;
  }

  @override
  Future<CartPageEntity> removeSelectedLines() async {
    final List<CartLineItemEntity> nextLines = _page.lines
        .where((CartLineItemEntity l) => !l.selected)
        .toList(growable: false);
    _page = _withSummary(
      _page.copyWith(
        lines: nextLines,
        selectionMode: false,
        checkoutEnabled: nextLines.isEmpty ? false : true,
      ),
    );
    return _page;
  }

  @override
  Future<CartPageEntity> setPromoExpanded(bool expanded) async {
    _page = _page.copyWith(
      showPromoExpanded: expanded,
      promo: _page.promo.copyWith(expanded: expanded, clearError: true),
    );
    return _page;
  }

  @override
  Future<CartPageEntity> dismissBanner() async {
    _page = _page.copyWith(clearBanner: true);
    return _page;
  }
}
