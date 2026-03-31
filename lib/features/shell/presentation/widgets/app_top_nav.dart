import 'package:flutter/material.dart';

import '../shell_nav_destinations.dart';

/// Top navigation for medium/large widths.
class AppTopNav extends StatelessWidget implements PreferredSizeWidget {
  const AppTopNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  final int selectedIndex;
  final ValueChanged<int> onTap;

  static const double _indicatorWidth = 28;
  static const double _indicatorHeight = 3;

  @override
  Size get preferredSize => const Size.fromHeight(64);

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
          SizedBox(
            height: 63,
            child: Row(
              children: List<Widget>.generate(
                shellNavDestinations.length,
                (int index) {
                  final ShellNavDestination destination =
                      shellNavDestinations[index];
                  final bool isSelected = index == selectedIndex;
                  final Color iconColor =
                      isSelected ? activeColor : inactiveColor;
                  return Expanded(
                    child: InkWell(
                      key: destination.key,
                      onTap: () => onTap(index),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            destination.icon,
                            size: 24,
                            color: iconColor,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            destination.title,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: iconColor,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 4),
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
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
