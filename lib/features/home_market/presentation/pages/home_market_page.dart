import 'package:flutter/material.dart';

import '../../../product_details/presentation/pages/product_details_page.dart';
import '../../domain/home_market_catalog_product.dart';
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
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => ProductDetailsPage(item: product.toHomeItemEntity()),
            ),
          );
        },
      ),
    );
  }
}
