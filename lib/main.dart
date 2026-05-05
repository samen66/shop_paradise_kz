import 'dart:developer' as developer;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'core/locale/app_locale_override_provider.dart';
import 'core/locale/locale_resolution.dart';
import 'core/routing/app_router.dart';
import 'core/routing/session_route_scope.dart';
import 'core/session/session_started_provider.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/data/google_sign_in_bootstrap.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  try {
    await initializeGoogleSignInPlugin();
  } on Object catch (error, stackTrace) {
    developer.log(
      'Google Sign-In init failed; federated sign-in disabled until fixed.',
      error: error,
      stackTrace: stackTrace,
    );
  }
  runApp(const ProviderScope(child: ShopParadiseApp()));
}

/// Root widget: theme, i18n, and [GoRouter] (welcome vs shell).
class ShopParadiseApp extends ConsumerStatefulWidget {
  const ShopParadiseApp({
    super.key,
    this.locale,
    this.themeMode,
    this.initialSessionStarted = false,
  });

  /// Overrides device locale (e.g. in tests).
  final Locale? locale;

  /// Overrides theme mode (e.g. in tests). Null uses [ThemeMode.system].
  final ThemeMode? themeMode;

  /// If true, skip Welcome and open main shell (e.g. bottom-nav tests).
  final bool initialSessionStarted;

  @override
  ConsumerState<ShopParadiseApp> createState() => _ShopParadiseAppState();
}

class _ShopParadiseAppState extends ConsumerState<ShopParadiseApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    ref.read(sessionStartedProvider.notifier).state =
        widget.initialSessionStarted || kIsWeb;
    final bool started = ref.read(sessionStartedProvider);
    _router = buildAppRouter(
      initialLocation: started ? '/shop' : '/welcome',
    );
  }

  @override
  void didUpdateWidget(ShopParadiseApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialSessionStarted != oldWidget.initialSessionStarted) {
      ref.read(sessionStartedProvider.notifier).state =
          widget.initialSessionStarted || kIsWeb;
      _router.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Locale? overrideLocale = ref.watch(appLocaleOverrideProvider);
    final bool sessionStarted = ref.watch(sessionStartedProvider);
    return SessionRouteScope(
      sessionStarted: sessionStarted,
      child: MaterialApp.router(
        title: 'Shop Paradise',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: widget.themeMode ?? ThemeMode.system,
        locale: widget.locale ?? overrideLocale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        localeListResolutionCallback:
            (List<Locale>? locales, Iterable<Locale> supportedLocales) {
              return resolveAppLocale(locales, supportedLocales);
            },
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
