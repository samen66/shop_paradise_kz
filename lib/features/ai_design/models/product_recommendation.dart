class ProductRecommendation {
  ProductRecommendation({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.quantity,
    required this.aiScore,
    required this.aiReason,
    this.imageAssetPath,
    this.isInCart = false,
  });

  final String id;
  final String name;
  final String category;
  final int price;
  final int quantity;
  final int aiScore;
  final String aiReason;
  final String? imageAssetPath;
  final bool isInCart;

  int get total => price * quantity;

  ProductRecommendation copyWith({
    String? id,
    String? name,
    String? category,
    int? price,
    int? quantity,
    int? aiScore,
    String? aiReason,
    String? imageAssetPath,
    bool? isInCart,
  }) {
    return ProductRecommendation(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      aiScore: aiScore ?? this.aiScore,
      aiReason: aiReason ?? this.aiReason,
      imageAssetPath: imageAssetPath ?? this.imageAssetPath,
      isInCart: isInCart ?? this.isInCart,
    );
  }
}

