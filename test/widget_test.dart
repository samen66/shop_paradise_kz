// Smoke tests for app shell, theme, and welcome localization.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shop_paradise_kz/main.dart';

void main() {
  testWidgets('Welcome shows Russian CTA when locale is ru', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ShopParadiseApp(
        locale: Locale('ru'),
        themeMode: ThemeMode.light,
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Смотреть каталог'), findsOneWidget);
    expect(find.text('Paradise'), findsOneWidget);
  });

  testWidgets('Welcome shows English CTA when locale is en', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ShopParadiseApp(
        locale: Locale('en'),
        themeMode: ThemeMode.light,
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Browse catalog'), findsOneWidget);
    expect(find.text('Paradise'), findsOneWidget);
  });

  testWidgets('Welcome shows Kazakh CTA when locale is kk', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ShopParadiseApp(
        locale: Locale('kk'),
        themeMode: ThemeMode.light,
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Каталогты ашу'), findsOneWidget);
    expect(find.text('Paradise'), findsOneWidget);
  });

  testWidgets('Welcome shows brand in dark theme', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ShopParadiseApp(
        locale: Locale('ru'),
        themeMode: ThemeMode.dark,
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Paradise'), findsOneWidget);
    expect(find.text('Смотреть каталог'), findsOneWidget);
  });
}
