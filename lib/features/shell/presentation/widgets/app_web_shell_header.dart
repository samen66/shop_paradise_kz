import 'dart:developer' as developer;

import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../shell_nav_destinations.dart';

/// E‑commerce style header for web (reference: logo, catalog, links, search,
/// profile / wishlist / cart). [onSelectTab] maps to shell [IndexedStack].
class AppWebShellHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppWebShellHeader({
    super.key,
    required this.selectedIndex,
    required this.onSelectTab,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelectTab;

  static const double _barHeight = 64;

  @override
  Size get preferredSize => const Size.fromHeight(_barHeight);

  void _openCatalogMenu(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List<Widget>.generate(shellNavDestinations.length, (
              int index,
            ) {
              final ShellNavDestination destination =
                  shellNavDestinations[index];
              return ListTile(
                leading: Icon(destination.icon),
                title: Text(destination.title),
                onTap: () {
                  onSelectTab(index);
                  Navigator.of(sheetContext).pop();
                },
              );
            }),
          ),
        );
      },
    );
  }

  Color _iconColor(BuildContext context, int tabIndex) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final bool isActive = selectedIndex == tabIndex;
    if (isActive) {
      return theme.brightness == Brightness.light
          ? Colors.black
          : scheme.onSurface;
    }
    return scheme.primary;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    return Material(
      color: scheme.surface,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: _barHeight - 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: <Widget>[
                  InkWell(
                    key: const Key('web_header_brand'),
                    onTap: () => onSelectTab(0),
                    child: Text(
                      l10n.appBrandTitle,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    key: const Key('web_header_catalog'),
                    onPressed: () {
                      developer.log('web_header_catalog');
                      _openCatalogMenu(context);
                    },
                    icon: const Icon(Icons.menu, size: 20),
                    label: Text(l10n.webHeaderCatalog),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: scheme.onSurface,
                      side: BorderSide(color: scheme.outline),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    developer.log('web_header_link_promotions');
                                  },
                                  child: Text(l10n.webHeaderLinkPromotions),
                                ),
                                TextButton(
                                  onPressed: () {
                                    developer.log('web_header_link_magazine');
                                  },
                                  child: Text(l10n.webHeaderLinkMagazine),
                                ),
                                TextButton(
                                  onPressed: () {
                                    developer.log('web_header_link_showrooms');
                                  },
                                  child: Text(l10n.webHeaderLinkShowrooms),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText: l10n.webHeaderSearchPlaceholder,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: scheme.onSurfaceVariant,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: BorderSide(
                                    color: scheme.outlineVariant,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: BorderSide(
                                    color: scheme.outlineVariant,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    key: const Key('web_header_nav_profile'),
                    icon: Icon(
                      Icons.person_outline,
                      color: _iconColor(context, 4),
                    ),
                    tooltip: shellNavDestinations[4].title,
                    onPressed: () => onSelectTab(4),
                  ),
                  IconButton(
                    key: const Key('web_header_nav_wishlist'),
                    icon: Icon(
                      Icons.favorite_border,
                      color: _iconColor(context, 1),
                    ),
                    tooltip: shellNavDestinations[1].title,
                    onPressed: () => onSelectTab(1),
                  ),
                  IconButton(
                    key: const Key('web_header_nav_cart'),
                    icon: Icon(
                      Icons.shopping_bag_outlined,
                      color: _iconColor(context, 3),
                    ),
                    tooltip: shellNavDestinations[3].title,
                    onPressed: () => onSelectTab(3),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: scheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ],
      ),
    );
  }
}
