import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/l10n/l10n_helpers.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../payment/presentation/payment_checkout_args.dart';
import '../../domain/entities/order_entities.dart';
import '../order_l10n.dart';

Color _statusColor(ColorScheme scheme, OrderStatus status) {
  return switch (status) {
    OrderStatus.processing => scheme.tertiary,
    OrderStatus.shipped => scheme.primary,
    OrderStatus.delivered => scheme.secondary,
    OrderStatus.cancelled => scheme.error,
  };
}

class OrderSummaryTile extends StatelessWidget {
  const OrderSummaryTile({
    super.key,
    required this.order,
    required this.onTap,
  });

  final OrderSummaryEntity order;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final BorderRadius radius = BorderRadius.circular(16);
    final String dateLabel = DateFormat.yMMMd().format(order.placedAt);
    final Color chipColor = _statusColor(colorScheme, order.status);
    final AppLocalizations l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.6),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      Icons.inventory_2_outlined,
                      color: colorScheme.onSurfaceVariant,
                      size: 28,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        order.reference,
                        style: textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dateLabel,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: <Widget>[
                          Chip(
                            visualDensity: VisualDensity.compact,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            label: Text(
                              l10n.orderStatusLabel(order.status),
                              style: textTheme.labelSmall?.copyWith(
                                color: chipColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            side: BorderSide(color: chipColor.withValues(alpha: 0.35)),
                            backgroundColor: chipColor.withValues(alpha: 0.12),
                          ),
                          Text(
                            l10n.orderItemsCount(order.itemCount),
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      formatPaymentMoney(order.total),
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Icon(
                      Icons.chevron_right,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
