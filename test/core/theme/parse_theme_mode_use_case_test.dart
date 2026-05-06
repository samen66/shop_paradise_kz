import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shop_paradise_kz/core/theme/parse_theme_mode_use_case.dart';

void main() {
  const ParseThemeModeUseCase useCase = ParseThemeModeUseCase();

  test('maps stored light and dark', () {
    expect(useCase(ParseThemeModeUseCase.valueLight), ThemeMode.light);
    expect(useCase(ParseThemeModeUseCase.valueDark), ThemeMode.dark);
  });

  test('null unknown and system string map to system', () {
    expect(useCase(null), ThemeMode.system);
    expect(useCase(ParseThemeModeUseCase.valueSystem), ThemeMode.system);
    expect(useCase('garbage'), ThemeMode.system);
  });
}
