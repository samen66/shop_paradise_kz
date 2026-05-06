import 'package:flutter/material.dart';

class StickyCartPanel extends StatelessWidget {
  const StickyCartPanel({
    super.key,
    required this.totalFormatted,
    required this.itemsLabel,
    required this.onAddAllToCart,
    required this.onOrderServices,
  });

  final String totalFormatted;
  final String itemsLabel;
  final VoidCallback onAddAllToCart;
  final VoidCallback onOrderServices;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;
    return SafeArea(
      top: false,
      child: Material(
        color: colors.surface,
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Итого: $totalFormatted',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          itemsLabel,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: onAddAllToCart,
                      icon: const Icon(Icons.shopping_cart_checkout_rounded),
                      label: const Text('Добавить всё'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: onOrderServices,
                  child: const Text('Заказать услуги →'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

