import 'package:flutter/material.dart';

import '../../domain/entities/cart_entities.dart';

class CartPromoSection extends StatelessWidget {
  const CartPromoSection({
    super.key,
    required this.promo,
    required this.expanded,
    required this.codeController,
    required this.onApply,
    required this.onClearApplied,
    required this.onToggleExpanded,
  });

  final CartPromoEntity promo;
  final bool expanded;
  final TextEditingController codeController;
  final VoidCallback onApply;
  final VoidCallback onClearApplied;
  final VoidCallback onToggleExpanded;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final bool showField = expanded || promo.expanded;
    return Material(
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outlineVariant.withValues(alpha: 0.6),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: onToggleExpanded,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.local_offer_outlined,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        promo.hasApplied
                            ? 'Promo applied'
                            : 'Promo code / coupon',
                        style: textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Icon(
                      showField
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                    ),
                  ],
                ),
              ),
            ),
            if (promo.hasApplied) ...<Widget>[
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Chip(
                    label: Text(promo.appliedCode ?? ''),
                    onDeleted: onClearApplied,
                  ),
                  Text(
                    '-\$${promo.discountAmount.toStringAsFixed(0)}',
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ],
            if (showField) ...<Widget>[
              const SizedBox(height: 12),
              TextField(
                controller: codeController,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  hintText: 'Enter code',
                  errorText: promo.errorMessage,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  isDense: true,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: onApply,
                  child: const Text('Apply'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
