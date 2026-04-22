import 'package:flutter/material.dart';

import '../shell_nav_destinations.dart';

/// Bottom bar: five outline icons, active tab uses onSurface + underline.
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    this.badgedIndices = const <int>{},
  });

  final int selectedIndex;
  final ValueChanged<int> onTap;
  /// Small reminder dots on tab icons (e.g. Profile index when vouchers need attention).
  final Set<int> badgedIndices;

  static const double _indicatorWidth = 28;
  static const double _indicatorHeight = 3;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final Color inactiveColor = scheme.primary;
    final Color activeColor = scheme.brightness == Brightness.light
        ? Colors.black
        : scheme.onSurface;
    return Material(
      color: scheme.surface,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Divider(
            height: 1,
            thickness: 1,
            color: scheme.outlineVariant.withValues(alpha: 0.5),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List<Widget>.generate(shellNavDestinations.length, (
                int index,
              ) {
                final bool isSelected = index == selectedIndex;
                final Color iconColor = isSelected
                    ? activeColor
                    : inactiveColor;
                final bool showBadge = badgedIndices.contains(index);
                return Expanded(
                  child: InkWell(
                    key: shellNavDestinations[index].key,
                    onTap: () => onTap(index),
                    customBorder: const CircleBorder(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Stack(
                          clipBehavior: Clip.none,
                          children: <Widget>[
                            Icon(
                              shellNavDestinations[index].icon,
                              size: 26,
                              color: iconColor,
                            ),
                            if (showBadge)
                              Positioned(
                                right: -2,
                                top: -2,
                                child: Container(
                                  key: index == 4
                                      ? const Key(
                                          'bottom_nav_profile_reminder_badge',
                                        )
                                      : null,
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: scheme.primary,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: scheme.surface,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOut,
                          height: _indicatorHeight,
                          width: isSelected ? _indicatorWidth : 0,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? activeColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
