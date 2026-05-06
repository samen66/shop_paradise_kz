import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n_helpers.dart';
import '../../../../l10n/app_localizations.dart';

import '../../domain/home_market_catalog_product.dart';
import '../home_market_catalog_l10n.dart';

/// Scrollable marketplace catalog: search, category chips, product grid.
///
/// When [standalone] is true, includes a pinned [SliverAppBar] with title and
/// search (full-screen [HomeMarketPage]). When false, omits that app bar so
/// the parent can supply the top chrome (e.g. [HomePage]).
class HomeMarketCatalogView extends StatefulWidget {
  const HomeMarketCatalogView({
    super.key,
    this.standalone = true,
    this.onProductTap,
  });

  /// If true, builds title + search inside a [SliverAppBar] (standalone route).
  final bool standalone;

  /// If null, grid cards are not tappable except the add-to-cart button.
  final void Function(HomeMarketCatalogProduct product)? onProductTap;

  static const List<HomeMarketCatalogProduct> products =
      <HomeMarketCatalogProduct>[
        HomeMarketCatalogProduct(
          id: 'fresh-fruit-basket',
          image: '🛒',
          price: 12.90,
          categoryId: 'groceries',
        ),
        HomeMarketCatalogProduct(
          id: 'kitchen-storage-set',
          image: '🫙',
          price: 24.50,
          categoryId: 'home_goods',
        ),
        HomeMarketCatalogProduct(
          id: 'scented-candle-trio',
          image: '🕯️',
          price: 18.00,
          categoryId: 'decor',
        ),
        HomeMarketCatalogProduct(
          id: 'laundry-organizer',
          image: '🧺',
          price: 29.99,
          categoryId: 'home_goods',
        ),
        HomeMarketCatalogProduct(
          id: 'indoor-plant-kit',
          image: '🌿',
          price: 34.75,
          categoryId: 'decor',
        ),
        HomeMarketCatalogProduct(
          id: 'organic-dairy-bundle',
          image: '🥛',
          price: 16.40,
          categoryId: 'groceries',
        ),
      ];

  @override
  State<HomeMarketCatalogView> createState() => _HomeMarketCatalogViewState();
}

class _HomeMarketCatalogViewState extends State<HomeMarketCatalogView> {
  String _query = '';
  String _selectedCategoryId = HomeMarketCatalogL10n.categoryIds.first;

  bool _productMatches(
    HomeMarketCatalogProduct product,
    AppLocalizations l10n,
  ) {
    final bool categoryMatches = _selectedCategoryId == 'all' ||
        product.categoryId == _selectedCategoryId;
    if (!categoryMatches) {
      return false;
    }
    if (_query.isEmpty) {
      return true;
    }
    final String q = _query.toLowerCase();
    final String title = l10n.homeMarketProductTitle(product.id).toLowerCase();
    final String cat =
        l10n.homeMarketCategoryLabel(product.categoryId).toLowerCase();
    return title.contains(q) || cat.contains(q) || product.id.contains(q);
  }

  List<HomeMarketCatalogProduct> _filteredProducts(AppLocalizations l10n) {
    return HomeMarketCatalogView.products
        .where(
          (HomeMarketCatalogProduct product) =>
              _productMatches(product, l10n),
        )
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;
    final AppLocalizations l10n = context.l10n;
    final List<HomeMarketCatalogProduct> filtered = _filteredProducts(l10n);

    final List<Widget> slivers = <Widget>[];

    if (widget.standalone) {
      slivers.add(
        SliverAppBar(
          pinned: true,
          expandedHeight: 150,
          title: Text(l10n.homeMarketplaceTitle),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(76),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: TextField(
                onChanged: (String value) {
                  setState(() {
                    _query = value.trim();
                  });
                },
                decoration: InputDecoration(
                  hintText: l10n.homeMarketSearchHint,
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      slivers.add(
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              key: const Key('home_market_catalog_search'),
              onChanged: (String value) {
                setState(() {
                  _query = value.trim();
                });
              },
              decoration: InputDecoration(
                hintText: l10n.homeMarketSearchHint,
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
        ),
      );
    }

    slivers.addAll(<Widget>[
      SliverToBoxAdapter(
        child: SizedBox(
          height: 62,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemBuilder: (BuildContext context, int index) {
              final String categoryId =
                  HomeMarketCatalogL10n.categoryIds[index];
              final bool isSelected = categoryId == _selectedCategoryId;
              return ChoiceChip(
                label: Text(l10n.homeMarketCategoryLabel(categoryId)),
                selected: isSelected,
                onSelected: (_) {
                  setState(() {
                    _selectedCategoryId = categoryId;
                  });
                },
                selectedColor: colors.primary.withValues(alpha: 0.18),
                labelStyle: theme.textTheme.labelLarge?.copyWith(
                  color: isSelected ? colors.primary : colors.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemCount: HomeMarketCatalogL10n.categoryIds.length,
          ),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
        sliver: SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final HomeMarketCatalogProduct product = filtered[index];
              final Widget card = Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 60,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: colors.surfaceContainerHighest,
                        ),
                        child: Text(
                          product.image,
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        l10n.homeMarketProductTitle(product.id),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: colors.onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      FilledButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add_shopping_cart_outlined),
                        label: Text(l10n.productAddToCartShort),
                      ),
                    ],
                  ),
                ),
              );

              if (widget.onProductTap == null) {
                return card;
              }
              return InkWell(
                key: Key('home_market_product_${product.id}'),
                borderRadius: BorderRadius.circular(12),
                onTap: () => widget.onProductTap!(product),
                child: card,
              );
            },
            childCount: filtered.length,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.68,
          ),
        ),
      ),
    ]);

    return CustomScrollView(
      slivers: slivers,
    );
  }
}
