import '../../../l10n/app_localizations.dart';
import '../domain/entities/order_entities.dart';

extension OrderStatusL10n on AppLocalizations {
  String orderStatusLabel(OrderStatus status) {
    return switch (status) {
      OrderStatus.processing => orderStatusProcessing,
      OrderStatus.shipped => orderStatusShipped,
      OrderStatus.delivered => orderStatusDelivered,
      OrderStatus.cancelled => orderStatusCancelled,
    };
  }
}
