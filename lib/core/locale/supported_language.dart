import 'package:flutter/widgets.dart';

/// Single source of truth for the languages the app ships translations for.
///
/// Anything that needs to know "what locales do we support?" — the language
/// picker, locale resolution, supported-locales lists, persisted user choice —
/// must derive from this enum instead of hardcoding language codes.
enum SupportedLanguage {
  en(code: 'en', nativeLabel: 'English'),
  kk(code: 'kk', nativeLabel: 'Қазақша'),
  ru(code: 'ru', nativeLabel: 'Русский');

  const SupportedLanguage({required this.code, required this.nativeLabel});

  /// IETF language subtag (e.g. `en`, `kk`, `ru`).
  final String code;

  /// Human-readable label in the language's own script (for the picker UI).
  final String nativeLabel;

  /// [Locale] used by `MaterialApp.supportedLocales` and `localeOf(context)`.
  Locale get locale => Locale(code);

  /// Used when the device locale matches none of [values].
  static const SupportedLanguage fallback = SupportedLanguage.ru;

  /// Resolves a stored/raw code (e.g. from [SharedPreferences]) to a value;
  /// returns `null` when [code] is unknown so callers can decide whether to
  /// fall back or follow the system locale.
  static SupportedLanguage? fromCode(String? code) {
    if (code == null || code.isEmpty) {
      return null;
    }
    for (final SupportedLanguage value in values) {
      if (value.code == code) {
        return value;
      }
    }
    return null;
  }

  /// Convenience for `MaterialApp.supportedLocales` / locale-resolution loops.
  static List<Locale> get supportedLocales =>
      values.map((SupportedLanguage l) => l.locale).toList(growable: false);
}
