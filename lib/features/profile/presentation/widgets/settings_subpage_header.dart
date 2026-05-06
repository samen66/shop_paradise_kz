import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n_helpers.dart';
import '../../../../core/theme/app_colors.dart';

/// Large **Settings** title with subtitle (design reference: Slada-style settings).
class SettingsSubpageHeader extends StatelessWidget {
  const SettingsSubpageHeader({
    super.key,
    required this.subtitle,
    this.showBack = true,
  });

  final String subtitle;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final String settingsTitle = context.l10n.settingsTitle;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 16, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (showBack)
            IconButton(
              onPressed: () => Navigator.of(context).maybePop(),
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              color: AppColors.onSurface,
            )
          else
            const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  settingsTitle,
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
