import 'package:flutter/material.dart';

/// Maps a persisted string to [ThemeMode] for storage round-trips.
class ParseThemeModeUseCase {
  const ParseThemeModeUseCase();

  static const String valueSystem = 'system';
  static const String valueLight = 'light';
  static const String valueDark = 'dark';

  ThemeMode call(String? stored) {
    switch (stored) {
      case valueLight:
        return ThemeMode.light;
      case valueDark:
        return ThemeMode.dark;
      case valueSystem:
      case null:
      default:
        return ThemeMode.system;
    }
  }

  String persistableValue(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return valueLight;
      case ThemeMode.dark:
        return valueDark;
      case ThemeMode.system:
        return valueSystem;
    }
  }
}
