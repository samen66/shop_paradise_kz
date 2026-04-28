import 'dart:ui';

import 'package:flutter/material.dart';

class AiInteriorPage extends StatefulWidget {
  const AiInteriorPage({super.key});

  @override
  State<AiInteriorPage> createState() => _AiInteriorPageState();
}

class _AiInteriorPageState extends State<AiInteriorPage> {
  bool _isScanning = false;

  static const List<_FurnitureRecommendation> _furniture = <_FurnitureRecommendation>[
    _FurnitureRecommendation(name: 'Nordic Sofa', price: 449),
    _FurnitureRecommendation(name: 'Aura Floor Lamp', price: 89),
    _FurnitureRecommendation(name: 'Oak Coffee Table', price: 175),
    _FurnitureRecommendation(name: 'Wall Art Set', price: 120),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;

    const double materialCost = 1250;
    const double laborCost = 880;
    final double total = materialCost + laborCost;

    return Scaffold(
      appBar: AppBar(title: const Text('AI Design & Quote')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              colors.primary.withValues(alpha: 0.10),
              colors.surface,
              colors.secondary.withValues(alpha: 0.08),
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            _GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Room Input', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 10),
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: colors.outlineVariant,
                      ),
                      color: colors.surfaceContainerHighest.withValues(alpha: 0.6),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.upload_rounded,
                          color: colors.primary,
                          size: 30,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Upload Image',
                          style: theme.textTheme.titleMedium,
                        ),
                        Text(
                          'PNG, JPG up to 10 MB',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: () {
                      setState(() {
                        _isScanning = !_isScanning;
                      });
                    },
                    icon: Icon(
                      _isScanning ? Icons.stop_circle_outlined : Icons.auto_awesome,
                    ),
                    label: Text(_isScanning ? 'Stop Scanning' : 'Start AI Scan'),
                  ),
                  if (_isScanning) ...<Widget>[
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Text(
                          'Scanning...',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(child: LinearProgressIndicator()),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 14),
            _GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Recommended Furniture', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 136,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _furniture.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (BuildContext context, int index) {
                        final _FurnitureRecommendation item = _furniture[index];
                        return SizedBox(
                          width: 168,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Icon(Icons.chair_alt_outlined, color: colors.primary),
                                  const SizedBox(height: 8),
                                  Text(
                                    item.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '\$${item.price.toStringAsFixed(0)}',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: colors.primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    'Shop in Marketplace',
                                    style: theme.textTheme.labelSmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Summary Report', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 10),
                  _summaryRow(context, 'Materials Estimate', materialCost),
                  const SizedBox(height: 6),
                  _summaryRow(context, 'Labor Estimate', laborCost),
                  const Divider(height: 22),
                  _summaryRow(context, 'Total Estimated Cost', total, emphasize: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(
    BuildContext context,
    String label,
    double value, {
    bool emphasize = false,
  }) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: emphasize
                ? theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)
                : theme.textTheme.bodyMedium,
          ),
        ),
        Text(
          '\$${value.toStringAsFixed(0)}',
          style: (emphasize ? theme.textTheme.titleSmall : theme.textTheme.bodyMedium)
              ?.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}

class _GlassCard extends StatelessWidget {
  const _GlassCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: colors.surface.withValues(alpha: 0.70),
            border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.65)),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _FurnitureRecommendation {
  const _FurnitureRecommendation({
    required this.name,
    required this.price,
  });

  final String name;
  final double price;
}
