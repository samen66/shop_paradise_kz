import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/l10n_helpers.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/shopping_notes_providers.dart';

/// Bar chart of total amounts per note category (local Drift data).
class SpendingAnalyticsPage extends ConsumerWidget {
  const SpendingAnalyticsPage({super.key});

  static const List<Color> _barColors = <Color>[
    Color(0xFF5C6BC0),
    Color(0xFF26A69A),
    Color(0xFFFFA726),
    Color(0xFFEF5350),
    Color(0xFFAB47BC),
    Color(0xFF42A5F5),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = context.l10n;
    final AsyncValue<Map<String, double>> sums =
        ref.watch(spendingByCategoryProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        title: Text(l10n.spendingByCategoryTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: sums.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (Object e, StackTrace st) => SelectableText.rich(
            TextSpan(
              children: <InlineSpan>[
                TextSpan(
                  text: l10n.spendingAnalyticsLoadError,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(text: e.toString()),
              ],
            ),
          ),
          data: (Map<String, double> data) {
            if (data.isEmpty) {
              return Center(
                child: Text(
                  l10n.spendingAnalyticsEmptyPrompt,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              );
            }
            final List<MapEntry<String, double>> entries =
                data.entries.toList()
                  ..sort(
                    (MapEntry<String, double> a, MapEntry<String, double> b) =>
                        b.value.compareTo(a.value),
                  );
            final double rawMax = entries
                .map((MapEntry<String, double> e) => e.value)
                .reduce((double a, double b) => a > b ? a : b);
            final double maxY = rawMax <= 0 ? 1 : rawMax;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  l10n.spendingAnalyticsSubtitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: maxY * 1.15,
                      barTouchData: BarTouchData(enabled: true),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              final int i = value.toInt();
                              if (i < 0 || i >= entries.length) {
                                return const SizedBox.shrink();
                              }
                              final String label = entries[i].key;
                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  label.length > 8
                                      ? '${label.substring(0, 8)}…'
                                      : label,
                                  style: const TextStyle(fontSize: 11),
                                ),
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              return Text(
                                value.toStringAsFixed(0),
                                style: const TextStyle(fontSize: 10),
                              );
                            },
                          ),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      gridData: const FlGridData(show: true, drawVerticalLine: false),
                      barGroups: List<BarChartGroupData>.generate(
                        entries.length,
                        (int i) {
                          final double v = entries[i].value;
                          return BarChartGroupData(
                            x: i,
                            barRods: <BarChartRodData>[
                              BarChartRodData(
                                toY: v,
                                width: 22,
                                color: _barColors[i % _barColors.length],
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(6),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
