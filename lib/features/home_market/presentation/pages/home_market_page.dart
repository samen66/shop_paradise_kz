import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n_helpers.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../product_details/presentation/pages/product_details_page.dart';
import '../../domain/home_market_catalog_product.dart';
import '../home_market_catalog_l10n.dart';
import '../widgets/home_market_catalog_view.dart';

/// Full-screen marketplace (pinned search app bar).
class HomeMarketPage extends StatelessWidget {
  const HomeMarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeMarketCatalogView(
        standalone: true,
        onProductTap: (HomeMarketCatalogProduct product) {
          final AppLocalizations l10n = context.l10n;
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => ProductDetailsPage(
                item: product.toHomeItemEntity(
                  localizedTitle: l10n.homeMarketProductTitle(product.id),
                  localizedCategoryLabel:
                      l10n.homeMarketCategoryLabel(product.categoryId),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
