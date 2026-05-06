import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../cart/presentation/pages/cart_page.dart';
import '../../home/presentation/pages/home_page.dart';
import '../../orders/presentation/pages/orders_page.dart';
import '../../profile/presentation/pages/profile_page.dart';
import '../../profile/presentation/providers/profile_providers.dart';
import '../../wishlist/presentation/pages/wishlist_page.dart';
import 'shell_nav_destinations.dart';
import 'shell_tab_placeholder_page.dart';
import 'widgets/app_bottom_nav.dart';
import 'widgets/app_top_nav.dart';
import 'widgets/app_web_shell_header.dart';

/// Main shell: [IndexedStack] + bottom bar (narrow) or top nav (wide);
/// on web + wide, [AppWebShellHeader] instead of [AppTopNav].
///
/// Tabs are local state; top-level [GoRouter] uses a single `/shop` route.
class AppShellPage extends ConsumerStatefulWidget {
  const AppShellPage({super.key});

  @override
  ConsumerState<AppShellPage> createState() => _AppShellPageState();
}

class _AppShellPageState extends ConsumerState<AppShellPage> {
  static const double _wideLayoutBreakpoint = 600;
  int _selectedIndex = 0;

  late final List<Widget> _pages = shellNavDestinations
      .asMap()
      .entries
      .map((MapEntry<int, ShellNavDestination> entry) {
        return switch (entry.key) {
          0 => const HomePage(),
          1 => const WishlistPage(),
          2 => const OrdersPage(),
          3 => const CartPage(),
          4 => const ProfilePage(),
          _ => ShellTabPlaceholderPage(title: entry.value.title),
        };
      })
      .toList(growable: false);

  void _onSelectIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool profileVoucherReminder = ref.watch(profileVoucherReminderProvider);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool isWide = constraints.maxWidth >= _wideLayoutBreakpoint;
        final bool useWebHeader = kIsWeb && isWide;
        return Scaffold(
          appBar: isWide
              ? AppBar(
                  automaticallyImplyLeading: false,
                  toolbarHeight: 0,
                  elevation: 0,
                  bottom: useWebHeader
                      ? AppWebShellHeader(
                          selectedIndex: _selectedIndex,
                          onSelectTab: _onSelectIndex,
                        )
                      : AppTopNav(
                          selectedIndex: _selectedIndex,
                          onTap: _onSelectIndex,
                        ),
                )
              : null,
          body: isWide
              ? IndexedStack(index: _selectedIndex, children: _pages)
              : SafeArea(
                  bottom: false,
                  child: IndexedStack(index: _selectedIndex, children: _pages),
                ),
          bottomNavigationBar: isWide
              ? null
              : SafeArea(
                  child: AppBottomNav(
                    selectedIndex: _selectedIndex,
                    onTap: _onSelectIndex,
                    badgedIndices: profileVoucherReminder ? <int>{4} : <int>{},
                  ),
                ),
        );
      },
    );
  }
}
