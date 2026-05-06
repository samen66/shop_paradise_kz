import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../prefs/app_preferences_keys.dart';
import '../prefs/shared_preferences_provider.dart';
import 'parse_theme_mode_use_case.dart';

final NotifierProvider<ThemeModeNotifier, ThemeMode> themeModeProvider =
    NotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);

/// Restores and persists [ThemeMode] via [SharedPreferences].
class ThemeModeNotifier extends Notifier<ThemeMode> {
  static const ParseThemeModeUseCase _parse = ParseThemeModeUseCase();

  @override
  ThemeMode build() {
    final SharedPreferences prefs = ref.read(sharedPreferencesProvider);
    return _parse(prefs.getString(AppPreferencesKeys.themeMode));
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final SharedPreferences prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(
      AppPreferencesKeys.themeMode,
      _parse.persistableValue(mode),
    );
    state = mode;
  }
}
