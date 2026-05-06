import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/l10n_helpers.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/profile_entities.dart';
import '../providers/profile_providers.dart';
import '../widgets/profile_icon_actions.dart';
import '../widgets/reward_progress_ring.dart';
import '../widgets/voucher_ticket_card.dart';
import '../widgets/voucher_visuals.dart';
import 'settings_page.dart';

class VouchersPage extends ConsumerStatefulWidget {
  const VouchersPage({super.key});

  @override
  ConsumerState<VouchersPage> createState() => _VouchersPageState();
}

class _VouchersPageState extends ConsumerState<VouchersPage> {
  int _segment = 0;

  void _snack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final AsyncValue<ProfileHubEntity> hub = ref.watch(profileHubProvider);
    final AsyncValue<VouchersHubEntity> vouchersState =
        ref.watch(vouchersHubProvider);

    return Scaffold(
      body: SafeArea(
        child: hub.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (Object e, StackTrace _) => Center(
            child: SelectableText.rich(
              TextSpan(
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
                text: l10n.errorMessageWithDetails(e.toString()),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          data: (ProfileHubEntity h) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () => Navigator.of(context).maybePop(),
                        icon: const Icon(Icons.arrow_back_rounded),
                      ),
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(h.user.avatarUrl),
                        onBackgroundImageError: (_, __) {},
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          key: const Key('vouchers_page_title'),
                          l10n.vouchersPageTitle,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ),
                      ProfileIconActions(
                        onScan: () => _snack(l10n.profileScannerSoon),
                        onFilter: () => _snack(l10n.profileFiltersSoon),
                        onSettings: () => openAppSettings(context),
                        filterHasBadge: h.voucherSummary.showReminder,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _SegmentTabs(
                    selectedIndex: _segment,
                    onChanged: (int i) => setState(() => _segment = i),
                    activeRewardsLabel: l10n.vouchersTabActiveRewards,
                    progressLabel: l10n.vouchersTabProgress,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: vouchersState.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (Object e, StackTrace _) => Center(
                      child: SelectableText.rich(
                        TextSpan(
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                          text: l10n.errorMessageWithDetails(e.toString()),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    data: (VouchersHubEntity v) {
                      if (_segment == 0) {
                        return ListView.builder(
                          key: const Key('vouchers_active_list'),
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                          itemCount: v.activeVouchers.length,
                          itemBuilder: (BuildContext context, int index) {
                            return VoucherTicketCard(
                              voucher: v.activeVouchers[index],
                            );
                          },
                        );
                      }
                      return GridView.builder(
                        key: const Key('vouchers_progress_grid'),
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.72,
                        ),
                        itemCount: v.milestones.length,
                        itemBuilder: (BuildContext context, int index) {
                          final RewardMilestoneEntity m = v.milestones[index];
                          return _MilestoneTile(milestone: m);
                        },
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

class _SegmentTabs extends StatelessWidget {
  const _SegmentTabs({
    required this.selectedIndex,
    required this.onChanged,
    required this.activeRewardsLabel,
    required this.progressLabel,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final String activeRewardsLabel;
  final String progressLabel;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _SegmentChip(
              key: const Key('vouchers_tab_active_rewards'),
              label: activeRewardsLabel,
              selected: selectedIndex == 0,
              onTap: () => onChanged(0),
            ),
          ),
          Expanded(
            child: _SegmentChip(
              key: const Key('vouchers_tab_progress'),
              label: progressLabel,
              selected: selectedIndex == 1,
              onTap: () => onChanged(1),
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentChip extends StatelessWidget {
  const _SegmentChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Material(
      color: selected
          ? AppColors.blobLightBlue.withValues(alpha: 0.85)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: selected ? AppColors.primary : theme.colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MilestoneTile extends StatelessWidget {
  const _MilestoneTile({required this.milestone});

  final RewardMilestoneEntity milestone;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Center(
                child: RewardProgressRing(
                  progress: milestone.progress,
                  showCompletedBadge: milestone.isCompleted,
                  child: Icon(
                    voucherKindIcon(milestone.kind),
                    color: AppColors.primary,
                    size: 28,
                  ),
                ),
              ),
            ),
            Text(
              milestone.title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              milestone.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
