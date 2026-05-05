import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/shopping_notes/presentation/pages/shopping_notes_page.dart';
import '../../features/shopping_notes/presentation/pages/spending_analytics_page.dart';
import '../../features/shell/presentation/app_shell_page.dart';
import '../../features/welcome/presentation/welcome_page.dart';
import '../session/session_started_provider.dart';
import 'session_route_scope.dart';

/// Builds the app [GoRouter]. Session is read from [SessionRouteScope] in [redirect].
GoRouter buildAppRouter({required String initialLocation}) {
  return GoRouter(
    initialLocation: initialLocation,
    redirect: (BuildContext context, GoRouterState state) {
      final SessionRouteScope? scope = context
          .getInheritedWidgetOfExactType<SessionRouteScope>();
      if (scope == null) {
        return null;
      }
      final bool started = scope.sessionStarted;
      final String loc = state.matchedLocation;
      if (!started && loc != '/welcome') {
        return '/welcome';
      }
      if (started && loc == '/welcome') {
        return '/shop';
      }
      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: '/welcome',
        builder: (BuildContext context, GoRouterState state) {
          return Consumer(
            builder: (BuildContext context, WidgetRef r, Widget? _) {
              return WelcomePage(
                onContinueToShop: () {
                  r.read(sessionStartedProvider.notifier).state = true;
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (!context.mounted) {
                      return;
                    }
                    context.go('/shop');
                  });
                },
              );
            },
          );
        },
      ),
      GoRoute(
        path: '/notes',
        builder: (BuildContext context, GoRouterState state) {
          return const ShoppingNotesPage();
        },
      ),
      GoRoute(
        path: '/analytics',
        builder: (BuildContext context, GoRouterState state) {
          return const SpendingAnalyticsPage();
        },
      ),
      GoRoute(
        path: '/shop',
        builder: (BuildContext context, GoRouterState state) {
          return const AppShellPage();
        },
      ),
    ],
  );
}
