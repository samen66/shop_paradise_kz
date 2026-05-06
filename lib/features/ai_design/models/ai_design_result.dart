import 'product_recommendation.dart';

class AiDesignResult {
  const AiDesignResult({
    required this.afterImageAssetPath,
    required this.summaryTitle,
    required this.summaryText,
    required this.summaryChips,
    required this.products,
    required this.createdAt,
  });

  final String afterImageAssetPath;
  final String summaryTitle;
  final String summaryText;
  final List<String> summaryChips;
  final List<ProductRecommendation> products;
  final DateTime createdAt;
}

