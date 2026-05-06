import '../models/ai_design_result.dart';
import '../models/ai_service.dart';
import '../models/product_recommendation.dart';

List<ProductRecommendation> buildMockProducts() {
  return <ProductRecommendation>[
    ProductRecommendation(
      id: '1',
      name: 'Диван угловой Comfort Pro',
      category: 'Мягкая мебель',
      price: 189000,
      quantity: 1,
      imageAssetPath: 'docs/screenshots/02_shopping_notes.png',
      aiScore: 5,
      aiReason: 'Идеально вписывается в современный стиль',
    ),
    ProductRecommendation(
      id: '2',
      name: 'Журнальный столик Nord',
      category: 'Столы',
      price: 45000,
      quantity: 1,
      imageAssetPath: 'docs/screenshots/03_spending_analytics.png',
      aiScore: 4,
      aiReason: 'Дополняет диван по цвету и стилю',
    ),
    ProductRecommendation(
      id: '3',
      name: 'Люстра Aura (6 плафонов)',
      category: 'Освещение',
      price: 67000,
      quantity: 1,
      imageAssetPath: 'docs/screenshots/01_welcome.png',
      aiScore: 5,
      aiReason: 'Подходит по высоте потолка',
    ),
    ProductRecommendation(
      id: '4',
      name: 'Ковёр Wool Soft 200×300',
      category: 'Декор',
      price: 38000,
      quantity: 1,
      imageAssetPath: 'docs/screenshots/02_shopping_notes.png',
      aiScore: 4,
      aiReason: 'Объединяет зону отдыха',
    ),
    ProductRecommendation(
      id: '5',
      name: 'Полка настенная модульная',
      category: 'Хранение',
      price: 22000,
      quantity: 2,
      imageAssetPath: 'docs/screenshots/03_spending_analytics.png',
      aiScore: 3,
      aiReason: 'Добавит функциональности',
    ),
    ProductRecommendation(
      id: '6',
      name: 'Шторы блэкаут 2.8м (пара)',
      category: 'Текстиль',
      price: 31000,
      quantity: 1,
      imageAssetPath: 'docs/screenshots/01_welcome.png',
      aiScore: 4,
      aiReason: 'Улучшит световой комфорт',
    ),
  ];
}

List<AiService> buildMockServices() {
  return <AiService>[
    const AiService(
      id: 'delivery',
      name: 'Доставка товаров',
      description: 'Доставка до двери в удобное время',
      price: 15000,
      emojiIcon: '🚚',
    ),
    const AiService(
      id: 'assembly',
      name: 'Сборка мебели',
      description: 'Сборка и установка мебели на месте',
      price: 35000,
      emojiIcon: '🔧',
    ),
    const AiService(
      id: 'lighting',
      name: 'Монтаж освещения',
      description: 'Установка люстр, светильников и проводки',
      price: 20000,
      emojiIcon: '💡',
    ),
    const AiService(
      id: 'painting',
      name: 'Покраска стен',
      description: 'Подготовка и покраска стен под новый интерьер',
      price: 80000,
      emojiIcon: '🎨',
    ),
    const AiService(
      id: 'curtains',
      name: 'Установка штор',
      description: 'Монтаж карниза и установка штор',
      price: 12000,
      emojiIcon: '🪟',
    ),
    const AiService(
      id: 'measurement',
      name: 'Замер помещения',
      description: 'Выезд специалиста и точные замеры',
      price: 0,
      emojiIcon: '📐',
    ),
  ];
}

AiDesignResult buildMockResult({
  required String afterImageAssetPath,
  required List<ProductRecommendation> products,
}) {
  return AiDesignResult(
    afterImageAssetPath: afterImageAssetPath,
    summaryTitle: 'Что AI нашёл',
    summaryText:
        'Обнаружена гостиная площадью ~18м², стиль — современный. '
        'Рекомендуем заменить диван, добавить журнальный столик '
        'и обновить освещение.',
    summaryChips: const <String>[
      'Современный',
      '18м²',
      'Освещение',
      'Мягкая мебель',
    ],
    products: products,
    createdAt: DateTime.now(),
  );
}

