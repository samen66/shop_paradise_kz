import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/shopping_notes/presentation/pages/shopping_notes_page.dart';
import '../../features/shopping_notes/presentation/pages/spending_analytics_page.dart';
import '../../features/shell/presentation/app_shell_page.dart';
import '../../features/welcome/presentation/welcome_page.dart';
import '../prefs/app_preferences_keys.dart';
import '../session/session_started_provider.dart';
import 'app_initial_location.dart';
import 'session_route_scope.dart';

/// Builds the app [GoRouter]. Session is read from [SessionRouteScope] in [redirect].
GoRouter buildAppRouter({
  required SharedPreferences sharedPreferences,
  required String initialLocation,
  bool? onboardingCompletedOverride,
}) {
  bool isOnboardingCompleted() {
    final bool? override = onboardingCompletedOverride;
    if (override != null) {
      return override;
    }
    return sharedPreferences.getBool(AppPreferencesKeys.onboardingCompleted) ??
        false;
  }

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
      final bool onboardingDone = isOnboardingCompleted();
      if (onboardingDone && loc == '/onboarding') {
        return resolveInitialAppLocation(
          prefs: sharedPreferences,
          sessionStarted: started,
          onboardingCompletedOverride: true,
        );
      }
      if (!onboardingDone && loc != '/onboarding') {
        return '/onboarding';
      }
      if (!started && loc != '/welcome' && loc != '/onboarding') {
        return '/welcome';
      }
      if (started && loc == '/welcome') {
        return '/shop';
      }
      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: '/onboarding',
        builder: (BuildContext context, GoRouterState state) {
          return const OnboardingPage();
        },
      ),
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
