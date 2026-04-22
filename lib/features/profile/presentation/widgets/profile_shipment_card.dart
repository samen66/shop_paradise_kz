import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/profile_entities.dart';

class ProfileShipmentCard extends StatelessWidget {
  const ProfileShipmentCard({
    super.key,
    required this.shipment,
    this.onTrack,
    this.onReview,
    this.onPay,
  });

  final ShipmentCardEntity shipment;
  final VoidCallback? onTrack;
  final VoidCallback? onReview;
  final VoidCallback? onPay;

  static String _statusLabel(ShipmentUiStatus status) {
    return switch (status) {
      ShipmentUiStatus.awaitingPayment => 'Awaiting payment',
      ShipmentUiStatus.packed => 'Packed',
      ShipmentUiStatus.shipped => 'Shipped',
      ShipmentUiStatus.delivered => 'Delivered',
    };
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 0,
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _ThumbGrid(urls: shipment.thumbnailUrls),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        shipment.orderReference,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        shipment.deliveryLabel,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: <Widget>[
                          Text(
                            _statusLabel(shipment.status),
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          if (shipment.status == ShipmentUiStatus.delivered) ...<Widget>[
                            const SizedBox(width: 6),
                            Icon(
                              Icons.check_circle,
                              size: 18,
                              color: scheme.primary,
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${shipment.itemCount} items',
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: _ActionForStatus(
                status: shipment.status,
                onTrack: onTrack,
                onReview: onReview,
                onPay: onPay,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionForStatus extends StatelessWidget {
  const _ActionForStatus({
    required this.status,
    this.onTrack,
    this.onReview,
    this.onPay,
  });

  final ShipmentUiStatus status;
  final VoidCallback? onTrack;
  final VoidCallback? onReview;
  final VoidCallback? onPay;

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      ShipmentUiStatus.awaitingPayment => OutlinedButton(
        onPressed: onPay,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        ),
        child: const Text('Pay now'),
      ),
      ShipmentUiStatus.packed || ShipmentUiStatus.shipped => FilledButton(
        onPressed: onTrack,
        style: FilledButton.styleFrom(
          minimumSize: Size.zero,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: const Text('Track'),
      ),
      ShipmentUiStatus.delivered => OutlinedButton(
        onPressed: onReview,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        ),
        child: const Text('Review'),
      ),
    };
  }
}

class _ThumbGrid extends StatelessWidget {
  const _ThumbGrid({required this.urls});

  final List<String> urls;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    if (urls.isEmpty) {
      return SizedBox(
        width: 76,
        height: 76,
        child: ColoredBox(
          color: theme.colorScheme.surfaceContainerHighest,
          child: Icon(
            Icons.image_outlined,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }
    if (urls.length == 1) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: SizedBox(
          width: 76,
          height: 76,
          child: Image.network(
            urls.first,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => ColoredBox(
              color: theme.colorScheme.surfaceContainerHighest,
            ),
          ),
        ),
      );
    }
    return SizedBox(
      width: 76,
      height: 76,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        itemCount: urls.length > 4 ? 4 : urls.length,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              urls[index],
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => ColoredBox(
                color: theme.colorScheme.surfaceContainerHighest,
              ),
            ),
          );
        },
      ),
    );
  }
}
