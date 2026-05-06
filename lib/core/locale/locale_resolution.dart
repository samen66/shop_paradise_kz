import 'package:flutter/widgets.dart';

import 'supported_language.dart';

/// Picks the first device locale whose [Locale.languageCode] matches one of
/// [supportedLocales]; otherwise [SupportedLanguage.fallback].
///
/// Matching by language code (not full locale) so e.g. a `kk_KZ` device locale
/// still resolves to our `kk` translations.
Locale resolveAppLocale(
  List<Locale>? deviceLocales,
  Iterable<Locale> supportedLocales,
) {
  if (deviceLocales == null || deviceLocales.isEmpty) {
    return SupportedLanguage.fallback.locale;
  }
  final List<Locale> supported = supportedLocales.toList(growable: false);
  for (final Locale deviceLocale in deviceLocales) {
    for (final Locale candidate in supported) {
      if (candidate.languageCode == deviceLocale.languageCode) {
        return candidate;
      }
    }
  }
  return SupportedLanguage.fallback.locale;
}
