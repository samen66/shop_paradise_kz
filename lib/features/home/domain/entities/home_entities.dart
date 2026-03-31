enum HomeSectionType {
  categories,
  products,
  newItems,
  flashSale,
  mostPopular,
  justForYou,
  unknown,
}

extension HomeSectionTypeX on HomeSectionType {
  bool get isJustForYou => this == HomeSectionType.justForYou;
}

enum HomeSectionLayout {
  horizontal,
  grid2,
  circles,
}

class HomeItemEntity {
  const HomeItemEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.price,
    this.oldPrice,
    this.discountLabel,
  });

  final String id;
  final String title;
  final String imageUrl;
  final double? price;
  final double? oldPrice;
  final String? discountLabel;
}

class HomeSectionEntity {
  const HomeSectionEntity({
    required this.type,
    required this.title,
    required this.layout,
    required this.items,
    this.hasMore = false,
    this.nextPage = 1,
  });

  final HomeSectionType type;
  final String title;
  final HomeSectionLayout layout;
  final List<HomeItemEntity> items;
  final bool hasMore;
  final int nextPage;
}

class HomePageEntity {
  const HomePageEntity({
    required this.sections,
  });

  final List<HomeSectionEntity> sections;
}
