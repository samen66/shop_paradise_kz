import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../product_details/presentation/pages/product_details_page.dart';
import '../../domain/entities/wishlist_entities.dart';
import '../mappers/wishlist_item_to_home_item.dart';
import '../providers/wishlist_controller.dart';
import '../widgets/wishlist_empty_state.dart';
import '../widgets/wishlist_item_card.dart';

class WishlistPage extends ConsumerWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<WishlistPageEntity> wishlistState = ref.watch(
      wishlistControllerProvider,
    );
    return wishlistState.when(
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
                'Failed to load wishlist',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(err.toString(), textAlign: TextAlign.center),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {
                  ref
                      .read(wishlistControllerProvider.notifier)
                      .restoreWishlist();
                },
                child: const Text('Try again'),
              ),
            ],
          ),
        ),
      ),
      data: (WishlistPageEntity data) {
        return CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              title: const Text('My Wishlist'),
              actions: <Widget>[
                IconButton(
                  tooltip: 'Clear',
                  onPressed: data.isEmpty
                      ? null
                      : () async {
                          await ref
                              .read(wishlistControllerProvider.notifier)
                              .clearWishlist();
                        },
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
            if (data.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: WishlistEmptyState(
                  onRestore: () {
                    ref
                        .read(wishlistControllerProvider.notifier)
                        .restoreWishlist();
                  },
                ),
              )
            else ...<Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Text(
                    '${data.items.length} saved items',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.48,
                  ),
                  delegate: SliverChildBuilderDelegate((
                    BuildContext context,
                    int index,
                  ) {
                    final WishlistItemEntity item = data.items[index];
                    return WishlistItemCard(
                      key: ValueKey<String>('wishlist_item_${item.id}'),
                      item: item,
                      onOpenProduct: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) =>
                                ProductDetailsPage(item: item.toHomeItem()),
                          ),
                        );
                      },
                      onRemove: () async {
                        await ref
                            .read(wishlistControllerProvider.notifier)
                            .removeItem(item.id);
                        if (!context.mounted) {
                          return;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${item.title} removed')),
                        );
                      },
                      onAddToCart: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${item.title} added to cart'),
                          ),
                        );
                      },
                    );
                  }, childCount: data.items.length),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
