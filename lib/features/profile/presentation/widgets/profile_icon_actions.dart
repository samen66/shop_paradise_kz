import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Three circular header actions: scan, filter (optional badge), settings.
class ProfileIconActions extends StatelessWidget {
  const ProfileIconActions({
    super.key,
    this.onScan,
    this.onFilter,
    this.onSettings,
    this.filterHasBadge = true,
  });

  final VoidCallback? onScan;
  final VoidCallback? onFilter;
  final VoidCallback? onSettings;
  final bool filterHasBadge;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _CircleIconButton(
          icon: Icons.crop_free_rounded,
          onPressed: onScan,
        ),
        const SizedBox(width: 8),
        _CircleIconButton(
          icon: Icons.filter_list_rounded,
          onPressed: onFilter,
          showBadge: filterHasBadge,
        ),
        const SizedBox(width: 8),
        _CircleIconButton(
          icon: Icons.settings_outlined,
          onPressed: onSettings,
        ),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    this.onPressed,
    this.showBadge = false,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final bool showBadge;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Material(
          color: AppColors.blobLightBlue,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(icon, size: 22, color: scheme.primary),
            ),
          ),
        ),
        if (showBadge)
          Positioned(
            right: 2,
            top: 2,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }
}
