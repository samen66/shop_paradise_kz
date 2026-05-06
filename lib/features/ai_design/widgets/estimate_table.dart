import 'package:flutter/material.dart';

import '../models/ai_service.dart';
import '../models/product_recommendation.dart';

class EstimateTable extends StatelessWidget {
  const EstimateTable({
    super.key,
    required this.products,
    required this.includeServices,
    required this.services,
  });

  final List<ProductRecommendation> products;
  final bool includeServices;
  final List<AiService> services;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;

    final Map<String, List<ProductRecommendation>> grouped =
        <String, List<ProductRecommendation>>{};
    for (final ProductRecommendation p in products) {
      grouped.putIfAbsent(p.category, () => <ProductRecommendation>[]).add(p);
    }

    final List<Widget> children = <Widget>[
      _SummaryCard(),
      const SizedBox(height: 12),
    ];

    for (final MapEntry<String, List<ProductRecommendation>> e in grouped.entries) {
      final int subtotal = e.value.fold<int>(0, (int sum, ProductRecommendation p) {
        return sum + p.total;
      });
      children.add(_CategoryHeader(title: e.key, subtotal: subtotal));
      children.add(const SizedBox(height: 6));
      for (final ProductRecommendation p in e.value) {
        children.add(_LineItemRow(product: p));
        children.add(const Divider(height: 18));
      }
      children.removeLast();
      children.add(const SizedBox(height: 12));
    }

    if (includeServices) {
      final List<AiService> selected =
          services.where((AiService s) => s.isSelected).toList(growable: false);
      if (selected.isNotEmpty) {
        children.add(Text('Услуги', style: theme.textTheme.titleMedium));
        children.add(const SizedBox(height: 6));
        for (final AiService s in selected) {
          children.add(
            Row(
              children: <Widget>[
                Expanded(child: Text('${s.emojiIcon} ${s.name}')),
                Text(
                  _formatKzt(s.price),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          );
          children.add(const SizedBox(height: 8));
        }
        children.add(const SizedBox(height: 8));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}

class _SummaryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Card(
      color: colors.surfaceContainerHighest.withValues(alpha: 0.5),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: <Widget>[
            const Icon(Icons.picture_as_pdf_outlined),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Итоговая смета',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  Text(
                    'Сформировано сегодня',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded),
          ],
        ),
      ),
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  const _CategoryHeader({required this.title, required this.subtotal});

  final String title;
  final int subtotal;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Text(
          _formatKzt(subtotal),
          style: theme.textTheme.titleSmall?.copyWith(
            color: colors.primary,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

class _LineItemRow extends StatelessWidget {
  const _LineItemRow({required this.product});

  final ProductRecommendation product;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium,
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 44,
          child: Text(
            '${product.quantity}×',
            textAlign: TextAlign.right,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 84,
          child: Text(
            _formatKzt(product.price),
            textAlign: TextAlign.right,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 92,
          child: Text(
            _formatKzt(product.total),
            textAlign: TextAlign.right,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
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

