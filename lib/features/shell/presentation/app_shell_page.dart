import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../cart/presentation/pages/cart_page.dart';
import '../../home/presentation/pages/home_page.dart';
import '../../orders/presentation/pages/orders_page.dart';
import '../../wishlist/presentation/pages/wishlist_page.dart';
import 'shell_nav_destinations.dart';
import 'shell_tab_placeholder_page.dart';
import 'widgets/app_bottom_nav.dart';
import 'widgets/app_top_nav.dart';
import 'widgets/app_web_shell_header.dart';

/// Main shell: [IndexedStack] + bottom bar (narrow) or top nav (wide);
/// on web + wide, [AppWebShellHeader] instead of [AppTopNav].
class AppShellPage extends StatefulWidget {
  const AppShellPage({super.key});

  @override
  State<AppShellPage> createState() => _AppShellPageState();
}

class _AppShellPageState extends State<AppShellPage> {
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
                  ),
                ),
        );
      },
    );
  }
}
