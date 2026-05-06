import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n_helpers.dart';
import '../../../../l10n/app_localizations.dart';

import '../../../ai_interior/presentation/pages/ai_interior_page.dart';
import '../../../home_market/domain/home_market_catalog_product.dart';
import '../../../home_market/presentation/widgets/home_market_catalog_view.dart';
import '../../../product_details/presentation/pages/product_details_page.dart';
import '../../../home_market/presentation/home_market_catalog_l10n.dart';
import '../../../service_hub/presentation/pages/service_hub_page.dart';

/// Home tab: marketplace catalog with search and filters; AI and Service Hub
/// in the app bar.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _openAi(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const AiInteriorPage(),
      ),
    );
  }

  void _openServiceHub(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const ServiceHubPage(),
      ),
    );
  }

  void _openProductDetails(
    BuildContext context,
    HomeMarketCatalogProduct product,
  ) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.shopHomeTitle),
        actions: <Widget>[
          IconButton(
            tooltip: context.l10n.homeAppBarAiDesignTooltip,
            icon: const Icon(Icons.auto_awesome_outlined),
            onPressed: () => _openAi(context),
          ),
          IconButton(
            tooltip: context.l10n.homeAppBarServiceHubTooltip,
            icon: const Icon(Icons.handyman_outlined),
            onPressed: () => _openServiceHub(context),
          ),
        ],
      ),
      body: HomeMarketCatalogView(
        standalone: false,
        onProductTap: (HomeMarketCatalogProduct product) {
          _openProductDetails(context, product);
        },
      ),
    );
  }
}
