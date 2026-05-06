import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n_helpers.dart';
import '../../../../l10n/app_localizations.dart';
import '../payment_card_option.dart';
import '../payment_checkout_args.dart';
import 'payment_methods_page.dart';
import '../widgets/payment_active_vouchers_sheet.dart';
import '../widgets/payment_footer_bar.dart';
import '../widgets/payment_info_card.dart';
import '../widgets/payment_item_row.dart';
import '../widgets/payment_shipping_address_sheet.dart';
import '../widgets/payment_shipping_option_tile.dart';

/// Checkout / Payment screen (after cart **Checkout**). Matches Shoppe-style
/// payment flow: address, contact, items, vouchers, shipping, pay.
class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key, required this.args});

  final PaymentCheckoutArgs args;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  static const double _expressShipping = 12;

  late String _shippingAddress;
  late String _phone;
  late String _email;
  int _shippingOptionIndex = 0;
  String _paymentMethodLabel = 'Mastercard •••• 1579';
  String _selectedCardId = 'mc_1579';

  double _extraVoucherDiscount = 0;
  String? _extraVoucherLabel;
  late bool _useCartDiscount;

  @override
  void initState() {
    super.initState();
    _shippingAddress =
        '26, Duong So 2, Thao Dien Ward, An Phu, District 2, Ho Chi Minh city';
    _phone = '+84932000000';
    _email = 'amandamorgan@example.com';
    _useCartDiscount =
        widget.args.cartDiscountAmount > 0 &&
        widget.args.cartDiscountLabel != null;
  }

  double get _merchandiseSubtotal => widget.args.merchandiseSubtotal;

  double get _cartDiscount =>
      _useCartDiscount ? widget.args.cartDiscountAmount : 0;

  String? get _cartDiscountLabel =>
      _useCartDiscount ? widget.args.cartDiscountLabel : null;

  double get _shippingCost => _shippingOptionIndex == 0 ? 0 : _expressShipping;

  double get _discountTotal => _cartDiscount + _extraVoucherDiscount;

  double get _total => (_merchandiseSubtotal - _discountTotal + _shippingCost)
      .clamp(0, double.infinity);

  Future<void> _openAddressSheet() async {
    final String? next = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) =>
          PaymentShippingAddressSheet(initialAddress: _shippingAddress),
    );
    if (next != null && next.isNotEmpty) {
      setState(() => _shippingAddress = next);
    }
  }

  Future<void> _openContactSheet() async {
    final PaymentContactResult? result =
        await showModalBottomSheet<PaymentContactResult>(
          context: context,
          isScrollControlled: true,
          useSafeArea: true,
          builder: (BuildContext context) => PaymentContactEditSheet(
            initialPhone: _phone,
            initialEmail: _email,
          ),
        );
    if (result != null) {
      setState(() {
        _phone = result.phone;
        _email = result.email;
      });
    }
  }

  Future<void> _openVouchers() async {
    final PaymentVoucher? applied = await showModalBottomSheet<PaymentVoucher>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) => const PaymentActiveVouchersSheet(),
    );
    if (applied != null) {
      setState(() {
        if (applied.percentOff != null) {
          _extraVoucherDiscount =
              _merchandiseSubtotal * applied.percentOff! / 100;
          _extraVoucherLabel = context.l10n.paymentPercentDiscount(
            applied.percentOff!.round(),
          );
        } else {
          _extraVoucherDiscount = applied.amountOff ?? 0;
          _extraVoucherLabel = applied.title;
        }
      });
    }
  }

  Future<void> _openPaymentMethods() async {
    final PaymentCardOption? card = await Navigator.of(context)
        .push<PaymentCardOption>(
          MaterialPageRoute<PaymentCardOption>(
            builder: (_) => PaymentMethodsPage(selectedId: _selectedCardId),
          ),
        );
    if (card != null) {
      setState(() {
        _selectedCardId = card.id;
        _paymentMethodLabel = card.summaryLabel;
      });
    }
  }

  Future<void> _onPay() async {
    if (!mounted) {
      return;
    }
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => const _PaymentProcessingDialog(),
    );
    await Future<void>.delayed(const Duration(milliseconds: 1600));
    if (!mounted) {
      return;
    }
    Navigator.of(context).pop();
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => _PaymentSuccessDialog(
        onTrackOrder: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _showPaymentError() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => _PaymentErrorDialog(
        onTryAgain: () => Navigator.of(context).pop(),
        onChangeMethod: () {
          Navigator.of(context).pop();
          _openPaymentMethods();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final int itemCount = widget.args.lines.length;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  title: Text(
                    l10n.paymentPageTitle,
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(<Widget>[
                      PaymentInfoCard(
                        title: l10n.paymentShippingAddressCardTitle,
                        body: _shippingAddress,
                        onEdit: _openAddressSheet,
                      ),
                      const SizedBox(height: 12),
                      PaymentInfoCard(
                        title: l10n.paymentContactInformationTitle,
                        body: '$_phone\n$_email',
                        onEdit: _openContactSheet,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            l10n.paymentItemsSectionTitle,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(width: 8),
                          _CountBadge(count: itemCount),
                          const Spacer(),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: colorScheme.primary,
                              side: BorderSide(color: colorScheme.primary),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: _openVouchers,
                            child: Text(l10n.paymentAddVoucher),
                          ),
                        ],
                      ),
                      if (_cartDiscountLabel != null ||
                          _extraVoucherLabel != null) ...<Widget>[
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: _DiscountChip(
                            label: _extraVoucherLabel != null
                                ? _extraVoucherLabel!
                                : l10n.paymentNamedDiscount(
                                    _cartDiscountLabel!,
                                  ),
                            onRemove: () {
                              setState(() {
                                if (_extraVoucherLabel != null) {
                                  _extraVoucherDiscount = 0;
                                  _extraVoucherLabel = null;
                                } else {
                                  _useCartDiscount = false;
                                }
                              });
                            },
                          ),
                        ),
                      ],
                      const SizedBox(height: 12),
                    ]),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList.separated(
                    itemCount: widget.args.lines.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (BuildContext context, int index) {
                      final PaymentLineSnapshot line = widget.args.lines[index];
                      return PaymentItemRow(line: line);
                    },
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      l10n.paymentShippingOptionsTitle,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      children: <Widget>[
                        PaymentShippingOptionTile(
                          title: l10n.paymentShippingStandard,
                          etaLabel: l10n.paymentShippingStandardEta,
                          priceLabel: l10n.paymentShippingFree,
                          selected: _shippingOptionIndex == 0,
                          onTap: () => setState(() => _shippingOptionIndex = 0),
                        ),
                        const SizedBox(height: 10),
                        PaymentShippingOptionTile(
                          title: l10n.paymentShippingExpress,
                          etaLabel: l10n.paymentShippingExpressEta,
                          priceLabel: formatPaymentMoney(_expressShipping),
                          selected: _shippingOptionIndex == 1,
                          onTap: () => setState(() => _shippingOptionIndex = 1),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.paymentDeliverySampleNote,
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          l10n.paymentMethodSectionTitle,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Material(
                          color: colorScheme.surfaceContainerHighest.withValues(
                            alpha: 0.65,
                          ),
                          borderRadius: BorderRadius.circular(14),
                          child: InkWell(
                            onTap: _openPaymentMethods,
                            borderRadius: BorderRadius.circular(14),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 14, 8, 14),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      _paymentMethodLabel,
                                      style: textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    style: IconButton.styleFrom(
                                      backgroundColor: colorScheme.primary,
                                      foregroundColor: colorScheme.onPrimary,
                                    ),
                                    onPressed: _openPaymentMethods,
                                    icon: const Icon(
                                      Icons.edit_outlined,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          PaymentFooterBar(
            totalLabel: formatPaymentMoney(_total),
            onPay: _onPay,
            onLongPay: _showPaymentError,
          ),
        ],
      ),
    );
  }
}

class _CountBadge extends StatelessWidget {
  const _CountBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '$count',
        style: Theme.of(
          context,
        ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _DiscountChip extends StatelessWidget {
  const _DiscountChip({required this.label, required this.onRemove});

  final String label;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: colorScheme.primary.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(999),
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: onRemove,
              icon: Icon(Icons.close, color: colorScheme.primary, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentProcessingDialog extends StatelessWidget {
  const _PaymentProcessingDialog();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final AppLocalizations l10n = context.l10n;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 48,
              height: 48,
              child: CircularProgressIndicator(
                strokeWidth: 4,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.paymentProcessingTitle,
              textAlign: TextAlign.center,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.paymentProcessingSubtitle,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentErrorDialog extends StatelessWidget {
  const _PaymentErrorDialog({
    required this.onTryAgain,
    required this.onChangeMethod,
  });

  final VoidCallback onTryAgain;
  final VoidCallback onChangeMethod;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final AppLocalizations l10n = context.l10n;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 36, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.pink.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.error_outline, color: Colors.pink.shade400),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.paymentErrorTitle,
              textAlign: TextAlign.center,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.paymentErrorBody,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: onTryAgain,
                    child: Text(l10n.paymentTryAgain),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                      foregroundColor: Theme.of(context).colorScheme.onSurface,
                    ),
                    onPressed: onChangeMethod,
                    child: Text(l10n.paymentChangeMethod),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentSuccessDialog extends StatelessWidget {
  const _PaymentSuccessDialog({required this.onTrackOrder});

  final VoidCallback onTrackOrder;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final AppLocalizations l10n = context.l10n;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.check_rounded,
                color: colorScheme.onPrimary,
                size: 36,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.paymentSuccessTitle,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.paymentSuccessBody,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest,
                  foregroundColor: Theme.of(context).colorScheme.onSurface,
                ),
                onPressed: onTrackOrder,
                child: Text(l10n.paymentTrackOrder),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
