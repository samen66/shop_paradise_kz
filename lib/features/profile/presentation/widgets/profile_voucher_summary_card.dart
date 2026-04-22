import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/profile_entities.dart';
import 'profile_rewards_ring.dart';
import 'voucher_visuals.dart';

class ProfileVoucherSummaryCard extends StatelessWidget {
  const ProfileVoucherSummaryCard({
    super.key,
    required this.summary,
    required this.onTap,
  });

  final ProfileVoucherSummaryEntity summary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final bool urgent = summary.expiringHeadline != null;
    final Color borderColor =
        urgent ? const Color(0xFFE57373) : scheme.outlineVariant;
    final String title = summary.expiringHeadline ?? 'Rewards progress';

    return Material(
      key: const Key('profile_voucher_summary_card'),
      color: scheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor, width: urgent ? 2 : 1),
          ),
          padding: const EdgeInsets.fromLTRB(16, 16, 14, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ProfileRewardsRing(
                progress: summary.overallRewardsProgress,
                icon: voucherKindIcon(summary.centerKind),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      key: const Key('profile_voucher_summary_title'),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: urgent ? const Color(0xFFC62828) : null,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      summary.body,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'My Vouchers',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: scheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
