import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/l10n/l10n_helpers.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../payment/presentation/payment_checkout_args.dart';
import '../../domain/entities/order_entities.dart';
import '../providers/orders_controller.dart';
import '../widgets/order_summary_tile.dart';
import '../widgets/orders_empty_state.dart';

class OrdersPage extends ConsumerWidget {
  const OrdersPage({super.key});

  void _showOrderDetailSheet(BuildContext context, OrderSummaryEntity order) {
    final String dateLabel = DateFormat.yMMMd().add_jm().format(order.placedAt);
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (BuildContext ctx) {
        final AppLocalizations l10n = ctx.l10n;
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                order.reference,
                style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.ordersPlacedOn(dateLabel),
                style: Theme.of(ctx).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              Text(
                l10n.ordersSheetSummaryLine(
                  order.itemCount,
                  formatPaymentMoney(order.total),
                ),
                style: Theme.of(ctx).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.ordersSheetTrackingPlaceholder,
                style: Theme.of(ctx).textTheme.bodySmall?.copyWith(
                  color: Theme.of(ctx).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<OrdersPageEntity> ordersState = ref.watch(
      ordersControllerProvider,
    );
    return ordersState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (Object err, StackTrace stack) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 12),
              Text(
                context.l10n.ordersFailedToLoad,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(err.toString(), textAlign: TextAlign.center),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {
                  ref.read(ordersControllerProvider.notifier).refreshOrders();
                },
                child: Text(context.l10n.commonTryAgain),
              ),
            ],
          ),
        ),
      ),
      data: (OrdersPageEntity data) {
        return CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              title: Text(context.l10n.ordersTitle),
              actions: <Widget>[
                IconButton(
                  tooltip: context.l10n.commonClear,
                  onPressed: data.isEmpty
                      ? null
                      : () {
                          ref.read(ordersControllerProvider.notifier).clearOrders();
                        },
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
            if (data.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: OrdersEmptyState(
                  onRestore: () {
                    ref
                        .read(ordersControllerProvider.notifier)
                        .restoreDemoOrders();
                  },
                ),
              )
            else ...<Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Text(
                    context.l10n.ordersCountHeader(data.orders.length),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((
                    BuildContext context,
                    int index,
                  ) {
                    final OrderSummaryEntity order = data.orders[index];
                    return OrderSummaryTile(
                      key: ValueKey<String>('order_${order.id}'),
                      order: order,
                      onTap: () {
                        _showOrderDetailSheet(context, order);
                      },
                    );
                  }, childCount: data.orders.length),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
