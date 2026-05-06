import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../models/product_recommendation.dart';
import '../providers/ai_design_provider.dart';
import '../widgets/before_after_slider.dart';
import '../widgets/estimate_table.dart';
import '../widgets/product_recommendation_card.dart';
import '../widgets/sticky_cart_panel.dart';

class ResultScreen extends ConsumerStatefulWidget {
  const ResultScreen({super.key});

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  String _filter = 'Все';
  String _sort = 'По релевантности AI';

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AiDesignState state = ref.watch(aiDesignProvider);
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;
    final List<ProductRecommendation> products = _applyFilterAndSort(
      products: state.products,
      filter: _filter,
      sort: _sort,
    );

    final int itemsCount = state.products.length;
    final String totalFormatted = _formatKzt(state.grandTotal);
    final String itemsLabel = '$itemsCount товаров';

    final String? beforePath = state.photo?.path;
    final String afterAsset = state.result?.afterImageAssetPath ??
        'docs/screenshots/01_welcome.png';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
              return;
            }
            context.go('/ai-design');
          },
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Назад',
        ),
        title: const Text('Результаты'),
        bottom: TabBar(
          controller: _tabs,
          tabs: const <Tab>[
            Tab(text: 'Дизайн'),
            Tab(text: 'Товары'),
            Tab(text: 'Смета'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: <Widget>[
          ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              AspectRatio(
                aspectRatio: 4 / 3,
                child: BeforeAfterSlider(
                  before: _BeforeImage(path: beforePath),
                  after: _AfterAsset(path: afterAsset),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: <Widget>[
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Сохранено (mock).')),
                        );
                      },
                      icon: const Icon(Icons.save_outlined),
                      label: const Text('Сохранить'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        await SharePlus.instance.share(
                          ShareParams(
                            text:
                                'Мой AI-дизайн от Paradise Home. Итог: $totalFormatted',
                          ),
                        );
                      },
                      icon: const Icon(Icons.ios_share_rounded),
                      label: const Text('Поделиться'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () async {
                        await ref.read(aiDesignProvider.notifier).startAnalysis();
                        if (!context.mounted) {
                          return;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Новый вариант готов.')),
                        );
                      },
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Новый'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Card(
                color: colors.surfaceContainerHighest.withValues(alpha: 0.55),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        state.result?.summaryTitle ?? 'Что AI нашёл',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        state.result?.summaryText ??
                            'AI подготовил рекомендации для вашего интерьера.',
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: (state.result?.summaryChips ??
                                const <String>['AI', 'Дизайн', 'Смета'])
                            .map(
                              (String c) => Chip(
                                label: Text(c),
                                backgroundColor: colors.primary.withValues(
                                  alpha: 0.10,
                                ),
                              ),
                            )
                            .toList(growable: false),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              _ProductsToolbar(
                filter: _filter,
                sort: _sort,
                onFilterChanged: (String v) => setState(() => _filter = v),
                onSortChanged: (String v) => setState(() => _sort = v),
              ),
              const SizedBox(height: 12),
              ...products.map((ProductRecommendation p) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Dismissible(
                    key: ValueKey<String>('ai_product_${p.id}'),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      color: colors.error.withValues(alpha: 0.12),
                      child: Icon(Icons.delete_outline, color: colors.error),
                    ),
                    onDismissed: (_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Удалено (mock).')),
                      );
                    },
                    child: ProductRecommendationCard(
                      product: p,
                      onToggleInCart: () => ref
                          .read(aiDesignProvider.notifier)
                          .toggleProductInCart(p.id),
                      onInfo: () {
                        showModalBottomSheet<void>(
                          context: context,
                          showDragHandle: true,
                          builder: (_) => _ProductInfoSheet(product: p),
                        );
                      },
                      onIncrement: () => ref
                          .read(aiDesignProvider.notifier)
                          .updateProductQuantity(p.id, p.quantity + 1),
                      onDecrement: () => ref
                          .read(aiDesignProvider.notifier)
                          .updateProductQuantity(p.id, p.quantity - 1),
                    ),
                  ),
                );
              }),
            ],
          ),
          ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              EstimateTable(
                products: state.products,
                includeServices: state.includeServices,
                services: state.services,
              ),
              const SizedBox(height: 14),
              Row(
                children: <Widget>[
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('PDF (mock).')),
                        );
                      },
                      icon: const Icon(Icons.picture_as_pdf_outlined),
                      label: const Text('Скачать PDF'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Email (mock).')),
                        );
                      },
                      icon: const Icon(Icons.email_outlined),
                      label: const Text('Отправить'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
            ],
          ),
        ],
      ),
      bottomNavigationBar: StickyCartPanel(
        totalFormatted: totalFormatted,
        itemsLabel: itemsLabel,
        onAddAllToCart: () {
          ref.read(aiDesignProvider.notifier).addAllToCart();
          final int count = ref.read(aiDesignProvider).products.length;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$count товаров добавлено в корзину'),
              action: SnackBarAction(
                label: 'Перейти',
                onPressed: () => context.go('/shop'),
              ),
            ),
          );
        },
        onOrderServices: () => context.push('/ai-design/services'),
      ),
    );
  }
}

class _BeforeImage extends StatelessWidget {
  const _BeforeImage({required this.path});

  final String? path;

  @override
  Widget build(BuildContext context) {
    final String? p = path;
    if (p == null) {
      return Container(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: const Center(child: Icon(Icons.image_outlined)),
      );
    }
    if (kIsWeb) {
      return Image.network(p, fit: BoxFit.cover);
    }
    return Image.file(File(p), fit: BoxFit.cover);
  }
}

class _AfterAsset extends StatelessWidget {
  const _AfterAsset({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) {
        return Container(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: const Center(child: Icon(Icons.broken_image_outlined)),
        );
      },
    );
  }
}

class _ProductsToolbar extends StatelessWidget {
  const _ProductsToolbar({
    required this.filter,
    required this.sort,
    required this.onFilterChanged,
    required this.onSortChanged,
  });

  final String filter;
  final String sort;
  final ValueChanged<String> onFilterChanged;
  final ValueChanged<String> onSortChanged;

  static const List<String> _filters = <String>[
    'Все',
    'Мебель',
    'Освещение',
    'Декор',
    'Покрытия',
  ];

  static const List<String> _sorts = <String>[
    'По релевантности AI',
    'По цене ↑',
    'По цене ↓',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (BuildContext context, int index) {
                final String f = _filters[index];
                return ChoiceChip(
                  selected: f == filter,
                  onSelected: (_) => onFilterChanged(f),
                  label: Text(f),
                );
              },
            ),
          ),
        ),
        const SizedBox(width: 10),
        DropdownButton<String>(
          value: sort,
          items: _sorts
              .map((String s) => DropdownMenuItem<String>(value: s, child: Text(s)))
              .toList(growable: false),
          onChanged: (String? v) {
            if (v == null) {
              return;
            }
            onSortChanged(v);
          },
        ),
      ],
    );
  }
}

class _ProductInfoSheet extends StatelessWidget {
  const _ProductInfoSheet({required this.product});

  final ProductRecommendation product;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(product.name, style: theme.textTheme.titleLarge),
          const SizedBox(height: 6),
          Text(
            product.category,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            product.aiReason,
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Text(
                'Цена: ${_formatKzt(product.price)}',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

List<ProductRecommendation> _applyFilterAndSort({
  required List<ProductRecommendation> products,
  required String filter,
  required String sort,
}) {
  Iterable<ProductRecommendation> filtered = products;
  if (filter != 'Все') {
    filtered = filtered.where((ProductRecommendation p) {
      return p.category.toLowerCase().contains(filter.toLowerCase());
    });
  }
  final List<ProductRecommendation> list =
      filtered.toList(growable: false);
  switch (sort) {
    case 'По цене ↑':
      list.sort((a, b) => a.price.compareTo(b.price));
      break;
    case 'По цене ↓':
      list.sort((a, b) => b.price.compareTo(a.price));
      break;
    default:
      list.sort((a, b) => b.aiScore.compareTo(a.aiScore));
  }
  return list;
}

String _formatKzt(int value) {
  final String s = value.toString();
  final StringBuffer buf = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    final int remaining = s.length - i;
    buf.write(s[i]);
    if (remaining > 1 && remaining % 3 == 1) {
      buf.write(' ');
    }
  }
  return '₸${buf.toString()}';
}

