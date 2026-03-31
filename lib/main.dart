import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/locale/locale_resolution.dart';
import 'core/theme/app_theme.dart';
import 'features/shell/presentation/app_shell_page.dart';
import 'features/welcome/presentation/welcome_page.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(
    const ProviderScope(
      child: ShopParadiseApp(),
    ),
  );
}

/// Root widget: theme, i18n, then Welcome (no bottom bar) or main shell.
class ShopParadiseApp extends StatefulWidget {
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

  /// If true, skip Welcome and open [AppShellPage] (e.g. bottom-nav tests).
  final bool initialSessionStarted;

  @override
  State<ShopParadiseApp> createState() => _ShopParadiseAppState();
}

class _ShopParadiseAppState extends State<ShopParadiseApp> {
  late bool _sessionStarted;

  @override
  void initState() {
    super.initState();
    _sessionStarted = widget.initialSessionStarted || kIsWeb;
  }

  @override
  void didUpdateWidget(ShopParadiseApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialSessionStarted != oldWidget.initialSessionStarted) {
      _sessionStarted = widget.initialSessionStarted || kIsWeb;
    }
  }

  void _onContinueFromWelcome() {
    setState(() {
      _sessionStarted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop Paradise',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: widget.themeMode ?? ThemeMode.system,
      locale: widget.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      localeListResolutionCallback: (
        List<Locale>? locales,
        Iterable<Locale> supportedLocales,
      ) {
        return resolveAppLocale(locales, supportedLocales);
      },
      home: _sessionStarted
          ? const AppShellPage()
          : WelcomePage(onContinueToShop: _onContinueFromWelcome),
      debugShowCheckedModeBanner: false,
    );
  }
}
