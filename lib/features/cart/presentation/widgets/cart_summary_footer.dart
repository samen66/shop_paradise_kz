import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n_helpers.dart';

import '../../domain/entities/cart_entities.dart';

class CartSummaryFooter extends StatelessWidget {
  const CartSummaryFooter({
    super.key,
    required this.summary,
    required this.checkoutEnabled,
    required this.onCheckout,
    required this.checkoutBlockedReason,
  });

  final CartSummaryEntity summary;
  final bool checkoutEnabled;
  final VoidCallback onCheckout;
  final String? checkoutBlockedReason;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Material(
      elevation: 8,
      shadowColor: Colors.black.withValues(alpha: 0.12),
      color: colorScheme.surface,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _SummaryRow(
                label: context.l10n.cartSubtotal,
                value: '\$${summary.subtotal.toStringAsFixed(0)}',
              ),
              if (summary.discount != null && summary.discount! > 0)
                _SummaryRow(
                  label: context.l10n.cartDiscountRow,
                  value: '-\$${summary.discount!.toStringAsFixed(0)}',
                  valueColor: colorScheme.primary,
                ),
              _SummaryRow(
                label: summary.shippingLabel,
                value: summary.shipping <= 0 && summary.subtotal > 0
                    ? context.l10n.cartFreeLabel
                    : '\$${summary.shipping.toStringAsFixed(0)}',
              ),
              if (summary.tax != null)
                _SummaryRow(
                  label: context.l10n.cartTax,
                  value: '\$${summary.tax!.toStringAsFixed(2)}',
                ),
              const Divider(height: 24),
              _SummaryRow(
                label: context.l10n.cartTotalRow,
                value: '\$${summary.total.toStringAsFixed(2)}',
                emphasize: true,
              ),
              if (checkoutBlockedReason != null) ...<Widget>[
                const SizedBox(height: 8),
                Text(
                  checkoutBlockedReason!,
                  style: textTheme.bodySmall?.copyWith(color: colorScheme.error),
                ),
              ],
              const SizedBox(height: 12),
              SizedBox(
                height: 52,
                child: FilledButton(
                  onPressed: checkoutEnabled ? onCheckout : null,
                  child: Text(context.l10n.cartCheckout),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.emphasize = false,
    this.valueColor,
  });

  final String label;
  final String value;
  final bool emphasize;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final TextStyle? labelStyle = emphasize
        ? textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)
        : textTheme.bodyMedium;
    final TextStyle? valueStyle = emphasize
        ? textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)
        : textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Expanded(child: Text(label, style: labelStyle)),
          Text(
            value,
            style: valueColor != null
                ? valueStyle?.copyWith(color: valueColor)
                : valueStyle,
          ),
        ],
      ),
    );
  }
}
