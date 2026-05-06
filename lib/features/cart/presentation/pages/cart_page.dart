import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/l10n_helpers.dart';
import '../../../payment/presentation/pages/payment_page.dart';
import '../../../payment/presentation/payment_checkout_args.dart';
import '../../domain/entities/cart_entities.dart';
import '../providers/cart_controller.dart';
import '../widgets/cart_empty_state.dart';
import '../widgets/cart_line_tile.dart';
import '../widgets/cart_promo_section.dart';
import '../widgets/cart_summary_footer.dart';

/// Cart screen. [CartFigmaScenario] (see [cart_entities.dart]) maps each
/// Figma node to a mock preset for design QA.
class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  final TextEditingController _promoController = TextEditingController();

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<CartPageEntity> cartState = ref.watch(
      cartControllerProvider,
    );
    return cartState.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (Object err, StackTrace stack) => Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Icon(Icons.error_outline, size: 48),
                const SizedBox(height: 12),
                Text(
                  context.l10n.cartFailedToLoad,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(err.toString(), textAlign: TextAlign.center),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () {
                    ref.read(cartControllerProvider.notifier).refreshCart();
                  },
                  child: Text(context.l10n.commonTryAgain),
                ),
              ],
            ),
          ),
        ),
      ),
      data: (CartPageEntity data) {
        return Scaffold(
          body: Column(
            children: <Widget>[
              Expanded(
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      pinned: true,
                      title: Text(context.l10n.cartTitle),
                      actions: <Widget>[
                        if (!data.isEmpty && data.selectionMode)
                          IconButton(
                            tooltip: context.l10n.cartTooltipDeleteSelected,
                            onPressed: data.selectedCount == 0
                                ? null
                                : () async {
                                    await ref
                                        .read(cartControllerProvider.notifier)
                                        .removeSelectedLines();
                                    if (!context.mounted) {
                                      return;
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          context.l10n.cartRemovedSelected,
                                        ),
                                      ),
                                    );
                                  },
                            icon: const Icon(Icons.delete_outline),
                          ),
                        if (!data.isEmpty && data.selectionMode)
                          TextButton(
                            onPressed: () {
                              ref
                                  .read(cartControllerProvider.notifier)
                                  .setSelectionMode(false);
                            },
                            child: Text(context.l10n.commonDone),
                          ),
                        if (!data.isEmpty && !data.selectionMode)
                          IconButton(
                            tooltip: context.l10n.cartTooltipSelectItems,
                            onPressed: () {
                              ref
                                  .read(cartControllerProvider.notifier)
                                  .setSelectionMode(true);
                            },
                            icon: const Icon(Icons.checklist_rtl_outlined),
                          ),
                      ],
                    ),
                    if (data.bannerMessage != null)
                      SliverToBoxAdapter(
                        child: _CartBanner(
                          message: data.bannerMessage!,
                          style: data.bannerStyle ?? CartBannerStyle.info,
                          onDismiss: () {
                            ref
                                .read(cartControllerProvider.notifier)
                                .dismissBanner();
                          },
                        ),
                      ),
                    if (data.isEmpty)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: CartEmptyState(
                          onBrowse: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  context.l10n.cartBrowseHomeSnackbar,
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    else ...<Widget>[
                      if (data.summary.freeShippingHint != null ||
                          data.summary.amountUntilFreeShipping != null)
                        SliverToBoxAdapter(
                          child: _FreeShippingCard(summary: data.summary),
                        ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                        sliver: SliverToBoxAdapter(
                          child: CartPromoSection(
                            promo: data.promo,
                            expanded: data.showPromoExpanded,
                            codeController: _promoController,
                            onApply: () async {
                              await ref
                                  .read(cartControllerProvider.notifier)
                                  .applyPromo(_promoController.text);
                              _promoController.clear();
                            },
                            onClearApplied: () {
                              ref
                                  .read(cartControllerProvider.notifier)
                                  .clearPromo();
                            },
                            onToggleExpanded: () {
                              ref
                                  .read(cartControllerProvider.notifier)
                                  .setPromoExpanded(
                                    !(data.showPromoExpanded ||
                                        data.promo.expanded),
                                  );
                            },
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverList.separated(
                          itemCount: data.lines.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (BuildContext context, int index) {
                            final CartLineItemEntity item = data.lines[index];
                            return CartLineTile(
                              key: ValueKey<String>('cart_line_${item.id}'),
                              item: item,
                              selectionMode: data.selectionMode,
                              onToggleSelected: (bool selected) {
                                ref
                                    .read(cartControllerProvider.notifier)
                                    .setLineSelected(item.id, selected);
                              },
                              onIncrement: () {
                                ref
                                    .read(cartControllerProvider.notifier)
                                    .updateQuantity(item.id, item.quantity + 1);
                              },
                              onDecrement: () {
                                ref
                                    .read(cartControllerProvider.notifier)
                                    .updateQuantity(
                                      item.id,
                                      item.quantity - 1,
                                    );
                              },
                              onRemove: () async {
                                await ref
                                    .read(cartControllerProvider.notifier)
                                    .removeLine(item.id);
                                if (!context.mounted) {
                                  return;
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      context.l10n.cartItemRemoved(item.title),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 24)),
                    ],
                  ],
                ),
              ),
              if (!data.isEmpty)
                CartSummaryFooter(
                  summary: data.summary,
                  checkoutEnabled: data.checkoutEnabled,
                  checkoutBlockedReason: data.summary.checkoutBlockedReason,
                  onCheckout: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => PaymentPage(
                          args: PaymentCheckoutArgs.fromCart(data),
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}

class _CartBanner extends StatelessWidget {
  const _CartBanner({
    required this.message,
    required this.style,
    required this.onDismiss,
  });

  final String message;
  final CartBannerStyle style;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final (Color bg, Color fg) = switch (style) {
      CartBannerStyle.success => (
        Colors.green.withValues(alpha: 0.12),
        Colors.green.shade800,
      ),
      CartBannerStyle.error => (
        colorScheme.error.withValues(alpha: 0.12),
        colorScheme.error,
      ),
      CartBannerStyle.info => (
        colorScheme.primary.withValues(alpha: 0.1),
        colorScheme.primary,
      ),
    };
    return Material(
      color: bg,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                message,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: fg, fontWeight: FontWeight.w600),
              ),
            ),
            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: onDismiss,
              icon: Icon(Icons.close, color: fg),
            ),
          ],
        ),
      ),
    );
  }
}

class _FreeShippingCard extends StatelessWidget {
  const _FreeShippingCard({required this.summary});

  final CartSummaryEntity summary;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final double? remaining = summary.amountUntilFreeShipping;
    final double progress = remaining != null && remaining > 0
        ? (summary.subtotal / (summary.subtotal + remaining)).clamp(0.0, 1.0)
        : 1.0;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Material(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.65),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                summary.freeShippingHint ?? 'Shipping',
                style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
              if (remaining != null) ...<Widget>[
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    minHeight: 6,
                    value: progress,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '\$${remaining.toStringAsFixed(0)} to free shipping',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
