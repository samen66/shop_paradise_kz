import 'package:flutter/material.dart';

import '../../domain/home_market_catalog_product.dart';

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

  static const List<String> categoryLabels = <String>[
    'All',
    'Groceries',
    'Home Goods',
    'Decor',
  ];

  static const List<HomeMarketCatalogProduct> products =
      <HomeMarketCatalogProduct>[
        HomeMarketCatalogProduct(
          id: 'fresh-fruit-basket',
          image: '🛒',
          title: 'Fresh Fruit Basket',
          price: 12.90,
          category: 'Groceries',
        ),
        HomeMarketCatalogProduct(
          id: 'kitchen-storage-set',
          image: '🫙',
          title: 'Kitchen Storage Set',
          price: 24.50,
          category: 'Home Goods',
        ),
        HomeMarketCatalogProduct(
          id: 'scented-candle-trio',
          image: '🕯️',
          title: 'Scented Candle Trio',
          price: 18.00,
          category: 'Decor',
        ),
        HomeMarketCatalogProduct(
          id: 'laundry-organizer',
          image: '🧺',
          title: 'Laundry Organizer',
          price: 29.99,
          category: 'Home Goods',
        ),
        HomeMarketCatalogProduct(
          id: 'indoor-plant-kit',
          image: '🌿',
          title: 'Indoor Plant Kit',
          price: 34.75,
          category: 'Decor',
        ),
        HomeMarketCatalogProduct(
          id: 'organic-dairy-bundle',
          image: '🥛',
          title: 'Organic Dairy Bundle',
          price: 16.40,
          category: 'Groceries',
        ),
      ];

  @override
  State<HomeMarketCatalogView> createState() => _HomeMarketCatalogViewState();
}

class _HomeMarketCatalogViewState extends State<HomeMarketCatalogView> {
  String _query = '';
  String _selectedCategory = HomeMarketCatalogView.categoryLabels.first;

  List<HomeMarketCatalogProduct> get _filteredProducts {
    return HomeMarketCatalogView.products
        .where((HomeMarketCatalogProduct product) {
          final bool categoryMatches = _selectedCategory == 'All' ||
              product.category.toLowerCase() ==
                  _selectedCategory.toLowerCase();
          final bool queryMatches = _query.isEmpty ||
              product.title.toLowerCase().contains(_query.toLowerCase());
          return categoryMatches && queryMatches;
        })
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;

    final List<Widget> slivers = <Widget>[];

    if (widget.standalone) {
      slivers.add(
        SliverAppBar(
          pinned: true,
          expandedHeight: 150,
          title: const Text('Home Marketplace'),
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
                decoration: const InputDecoration(
                  hintText: 'Search products, brands, supplies...',
                  prefixIcon: Icon(Icons.search),
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
              decoration: const InputDecoration(
                hintText: 'Search products, brands, supplies...',
                prefixIcon: Icon(Icons.search),
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
              final String category =
                  HomeMarketCatalogView.categoryLabels[index];
              final bool isSelected = category == _selectedCategory;
              return ChoiceChip(
                label: Text(category),
                selected: isSelected,
                onSelected: (_) {
                  setState(() {
                    _selectedCategory = category;
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
            itemCount: HomeMarketCatalogView.categoryLabels.length,
          ),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
        sliver: SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final HomeMarketCatalogProduct product =
                  _filteredProducts[index];
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
                        product.title,
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
                        label: const Text('Add to Cart'),
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
            childCount: _filteredProducts.length,
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
