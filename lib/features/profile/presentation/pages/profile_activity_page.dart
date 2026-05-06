import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/l10n/l10n_helpers.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/profile_entities.dart';
import '../providers/profile_providers.dart';
import '../widgets/profile_donut_chart.dart';
import '../widgets/profile_icon_actions.dart';
import 'profile_history_page.dart';
import 'settings_page.dart';

class ProfileActivityPage extends ConsumerStatefulWidget {
  const ProfileActivityPage({super.key});

  @override
  ConsumerState<ProfileActivityPage> createState() =>
      _ProfileActivityPageState();
}

class _ProfileActivityPageState extends ConsumerState<ProfileActivityPage> {
  static const List<String> _monthKeys = <String>['2026-04', '2026-03'];
  int _monthIndex = 0;

  void _snack(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final String monthKey = _monthKeys[_monthIndex];
    final AsyncValue<ProfileHubEntity> hub = ref.watch(profileHubProvider);
    final AsyncValue<ActivityMonthEntity> activity = ref.watch(
      profileActivityProvider(monthKey),
    );

    return Scaffold(
      body: SafeArea(
        child: hub.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (Object e, _) => Center(
            child: Text(context.l10n.errorMessageWithDetails(e.toString())),
          ),
          data: (ProfileHubEntity hubData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 8, 12, 8),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.arrow_back_rounded),
                        onPressed: () => Navigator.of(context).maybePop(),
                      ),
                      CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage(hubData.user.avatarUrl),
                        onBackgroundImageError: (_, __) {},
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          context.l10n.profileMyActivity,
                          key: const Key('profile_activity_title'),
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      ProfileIconActions(
                        onScan: () =>
                            _snack(context, context.l10n.profileScannerSoon),
                        onFilter: () =>
                            _snack(context, context.l10n.profileFiltersSoon),
                        onSettings: () => openAppSettings(context),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: activity.when(
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (Object e, _) => Center(
                      child: Text(
                        context.l10n.errorMessageWithDetails(e.toString()),
                      ),
                    ),
                    data: (ActivityMonthEntity data) {
                      final NumberFormat money = NumberFormat.currency(
                        locale: 'en_US',
                        symbol: r'$',
                        decimalDigits: 2,
                      );
                      return ListView(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                        children: <Widget>[
                          _MonthSelector(label: data.monthLabel),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                onPressed: _monthIndex > 0
                                    ? () => setState(() => _monthIndex -= 1)
                                    : null,
                                icon: Icon(
                                  Icons.chevron_left,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              ProfileDonutChart(
                                key: const Key('profile_activity_donut'),
                                segments: data.segments,
                                totalLabel: context.l10n.paymentTotalLabel,
                                totalAmountText: money.format(data.totalAmount),
                              ),
                              IconButton(
                                onPressed:
                                    _monthIndex < _monthKeys.length - 1
                                    ? () => setState(() => _monthIndex += 1)
                                    : null,
                                icon: Icon(
                                  Icons.chevron_right,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 2.4,
                            children: data.segments.map((
                              ActivitySegmentEntity s,
                            ) {
                              return _LegendPill(
                                color: Color(s.swatchArgb),
                                label:
                                    '${s.label} ${money.format(s.amount)}',
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: _StatOrb(
                                  value: '${data.orderedCount}',
                                  caption: context.l10n.profileStatOrdered,
                                ),
                              ),
                              Expanded(
                                child: _StatOrb(
                                  value: '${data.receivedCount}',
                                  caption: context.l10n.profileStatReceived,
                                ),
                              ),
                              Expanded(
                                child: _StatOrb(
                                  value: '${data.toReceiveCount}',
                                  caption: context.l10n.profileStatToReceive,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 28),
                          FilledButton(
                            key: const Key('profile_order_history_button'),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => const ProfileHistoryPage(),
                                ),
                              );
                            },
                            child: Text(context.l10n.profileOrderHistory),
                          ),
                        ],
                      );
                    },
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

class _MonthSelector extends StatelessWidget {
  const _MonthSelector({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: scheme.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _LegendPill extends StatelessWidget {
  const _LegendPill({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _StatOrb extends StatelessWidget {
  const _StatOrb({required this.value, required this.caption});

  final String value;
  final String caption;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      children: <Widget>[
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.colorScheme.surface,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              value,
              style: theme.textTheme.titleMedium?.copyWith(
                color: AppColors.onPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          caption,
          style: theme.textTheme.labelMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
