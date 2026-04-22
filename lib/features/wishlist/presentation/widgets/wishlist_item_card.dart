import 'package:flutter/material.dart';

import '../../domain/entities/wishlist_entities.dart';

class WishlistItemCard extends StatelessWidget {
  const WishlistItemCard({
    super.key,
    required this.item,
    required this.onRemove,
    required this.onAddToCart,
    required this.onOpenProduct,
  });

  final WishlistItemEntity item;
  final VoidCallback onRemove;
  final VoidCallback onAddToCart;
  final VoidCallback onOpenProduct;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final BorderRadius borderRadius = BorderRadius.circular(16);
    return Material(
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: BorderSide(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onOpenProduct,
        borderRadius: borderRadius,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.network(
                        item.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => ColoredBox(
                          color: colorScheme.surfaceContainerHighest,
                          child: const SizedBox.expand(),
                        ),
                      ),
                    ),
                  ),
                  if (item.discountLabel != null)
                    Positioned(
                      left: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          item.discountLabel!,
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: IconButton.filledTonal(
                      tooltip: 'Remove',
                      onPressed: onRemove,
                      icon: const Icon(Icons.favorite),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.brand,
                    style: textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      Text(
                        '\$${item.currentPrice.toStringAsFixed(0)}',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (item.originalPrice != null) ...<Widget>[
                        const SizedBox(width: 8),
                        Text(
                          '\$${item.originalPrice!.toStringAsFixed(0)}',
                          style: textTheme.bodySmall?.copyWith(
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 10),
                  _AvailabilityChip(availability: item.availability),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed:
                          item.availability ==
                              WishlistItemAvailability.outOfStock
                          ? null
                          : onAddToCart,
                      child: Text(
                        item.availability == WishlistItemAvailability.outOfStock
                            ? 'Out of stock'
                            : 'Add to cart',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AvailabilityChip extends StatelessWidget {
  const _AvailabilityChip({required this.availability});

  final WishlistItemAvailability availability;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final (String label, Color color) = switch (availability) {
      WishlistItemAvailability.inStock => ('In stock', Colors.green),
      WishlistItemAvailability.limited => ('Low stock', Colors.orange),
      WishlistItemAvailability.outOfStock => ('Unavailable', colorScheme.error),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
