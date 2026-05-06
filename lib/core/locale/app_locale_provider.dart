import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../prefs/app_preferences_keys.dart';
import '../prefs/shared_preferences_provider.dart';
import 'supported_language.dart';

/// User's selected app locale.
///
/// `null` means "follow the device locale" — `MaterialApp` resolves it via
/// [Localizations] + the registered `localeListResolutionCallback`.
final NotifierProvider<AppLocaleNotifier, Locale?> appLocaleProvider =
    NotifierProvider<AppLocaleNotifier, Locale?>(AppLocaleNotifier.new);

/// Restores and persists the user's chosen [Locale] via [SharedPreferences].
///
/// Mirrors the design of `ThemeModeNotifier` (parity for theme + language).
class AppLocaleNotifier extends Notifier<Locale?> {
  @override
  Locale? build() {
    final SharedPreferences prefs = ref.read(sharedPreferencesProvider);
    final SupportedLanguage? stored = SupportedLanguage.fromCode(
      prefs.getString(AppPreferencesKeys.languageCode),
    );
    return stored?.locale;
  }

  /// Persist the user's explicit choice and emit the new locale.
  Future<void> setLanguage(SupportedLanguage language) async {
    final SharedPreferences prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(AppPreferencesKeys.languageCode, language.code);
    state = language.locale;
  }

  /// Drop any user override and follow the device locale again.
  Future<void> useSystemLanguage() async {
    final SharedPreferences prefs = ref.read(sharedPreferencesProvider);
    await prefs.remove(AppPreferencesKeys.languageCode);
    state = null;
  }
}
