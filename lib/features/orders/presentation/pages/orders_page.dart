import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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
                'Placed $dateLabel',
                style: Theme.of(ctx).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              Text(
                '${order.itemCount} items · ${formatPaymentMoney(order.total)}',
                style: Theme.of(ctx).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Text(
                'Full order tracking will appear here once connected to your store backend.',
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
                'Failed to load orders',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(err.toString(), textAlign: TextAlign.center),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {
                  ref.read(ordersControllerProvider.notifier).refreshOrders();
                },
                child: const Text('Try again'),
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
              title: const Text('My orders'),
              actions: <Widget>[
                IconButton(
                  tooltip: 'Clear',
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
                    '${data.orders.length} orders',
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
