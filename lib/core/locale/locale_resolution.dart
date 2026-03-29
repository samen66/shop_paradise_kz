import 'package:flutter/material.dart';

/// Picks the first device locale that matches [supportedLocales], else Russian.
Locale resolveAppLocale(
  List<Locale>? locales,
  Iterable<Locale> supportedLocales,
) {
  if (locales == null || locales.isEmpty) {
    return const Locale('ru');
  }
  final List<Locale> supported = supportedLocales.toList();
  for (final Locale deviceLocale in locales) {
    for (final Locale candidate in supported) {
      if (candidate.languageCode == deviceLocale.languageCode) {
        return candidate;
      }
    }
  }
  return const Locale('ru');
}
