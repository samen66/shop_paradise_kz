import '../../../l10n/app_localizations.dart';

/// Maps mock catalog [categoryId] / [productId] to ARB strings.
extension HomeMarketCatalogL10n on AppLocalizations {
  /// Category chip ids for [HomeMarketCatalogView] (stable, not user-facing).
  static const List<String> categoryIds = <String>[
    'all',
    'groceries',
    'home_goods',
    'decor',
  ];

  String homeMarketCategoryLabel(String categoryId) {
    return switch (categoryId) {
      'all' => homeMarketCategoryAll,
      'groceries' => homeMarketCategoryGroceries,
      'home_goods' => homeMarketCategoryHomeGoods,
      'decor' => homeMarketCategoryDecor,
      _ => categoryId,
    };
  }

  String homeMarketProductTitle(String productId) {
    return switch (productId) {
      'fresh-fruit-basket' => homeMarketProductFreshFruitBasket,
      'kitchen-storage-set' => homeMarketProductKitchenStorageSet,
      'scented-candle-trio' => homeMarketProductScentedCandleTrio,
      'laundry-organizer' => homeMarketProductLaundryOrganizer,
      'indoor-plant-kit' => homeMarketProductIndoorPlantKit,
      'organic-dairy-bundle' => homeMarketProductOrganicDairyBundle,
      _ => productId,
    };
  }
}
