import 'package:flutter/material.dart';

import 'core/locale/locale_resolution.dart';
import 'core/theme/app_theme.dart';
import 'features/welcome/presentation/welcome_page.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(const ShopParadiseApp());
}

/// Root widget: theme, i18n (en / ru / kk), and locale resolution.
class ShopParadiseApp extends StatelessWidget {
  const ShopParadiseApp({super.key, this.locale, this.themeMode});

  /// Overrides device locale (e.g. in tests).
  final Locale? locale;

  /// Overrides theme mode (e.g. in tests). Null uses [ThemeMode.system].
  final ThemeMode? themeMode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop Paradise',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode ?? ThemeMode.system,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      localeListResolutionCallback: (
        List<Locale>? locales,
        Iterable<Locale> supportedLocales,
      ) {
        return resolveAppLocale(locales, supportedLocales);
      },
      home: const WelcomePage(),
    );
  }
}
