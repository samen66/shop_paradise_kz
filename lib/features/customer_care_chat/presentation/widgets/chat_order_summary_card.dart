import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../orders/domain/entities/order_entities.dart';
import 'chat_thumb_grid.dart';

String _orderStatusLabel(OrderStatus status) {
  return switch (status) {
    OrderStatus.processing => 'Processing',
    OrderStatus.shipped => 'Shipped',
    OrderStatus.delivered => 'Delivered',
    OrderStatus.cancelled => 'Cancelled',
  };
}

class ChatOrderSummaryCard extends StatelessWidget {
  const ChatOrderSummaryCard({
    super.key,
    required this.order,
    required this.itemCountLabel,
    required this.deliveryLabel,
    this.selected = false,
    this.selectLabel,
    this.selectedLabel,
    this.onSelect,
    this.showSelectButton = false,
  });

  final OrderSummaryEntity order;
  final String itemCountLabel;
  final String deliveryLabel;
  final bool selected;
  final String? selectLabel;
  final String? selectedLabel;
  final VoidCallback? onSelect;
  final bool showSelectButton;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: selected ? AppColors.primary : scheme.outlineVariant,
          width: selected ? 2 : 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ChatThumbGrid(orderId: order.id, size: 64),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Order ${order.reference}',
                          style: textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: scheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          itemCountLabel,
                          style: textTheme.labelSmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    deliveryLabel,
                    style: textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          _orderStatusLabel(order.status),
                          style: textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      if (order.status == OrderStatus.delivered)
                        Icon(Icons.check_circle, color: scheme.primary, size: 22),
                    ],
                  ),
                  if (showSelectButton && onSelect != null) ...<Widget>[
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: selected
                          ? FilledButton(
                              onPressed: null,
                              style: FilledButton.styleFrom(
                                minimumSize: const Size(100, 40),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                              ),
                              child: Text(selectedLabel ?? 'Selected'),
                            )
                          : OutlinedButton(
                              onPressed: onSelect,
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(100, 40),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                foregroundColor: AppColors.primary,
                                side: const BorderSide(color: AppColors.primary),
                              ),
                              child: Text(selectLabel ?? 'Select'),
                            ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}