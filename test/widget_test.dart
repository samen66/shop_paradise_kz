// Smoke tests for app shell, theme, and welcome localization.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shop_paradise_kz/features/shell/presentation/widgets/app_bottom_nav.dart';
import 'package:shop_paradise_kz/features/shell/presentation/widgets/app_top_nav.dart';
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

  testWidgets('Bottom nav switches to Wishlist tab', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ShopParadiseApp(
        locale: Locale('en'),
        themeMode: ThemeMode.light,
        initialSessionStarted: true,
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsWidgets);
    await tester.tap(find.byKey(const Key('bottom_nav_1')));
    await tester.pumpAndSettle();
    expect(find.text('Wishlist'), findsWidgets);
  });

  testWidgets('Bottom nav switches to Orders then back to Home', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ShopParadiseApp(
        locale: Locale('en'),
        themeMode: ThemeMode.light,
        initialSessionStarted: true,
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('bottom_nav_2')));
    await tester.pumpAndSettle();
    expect(find.text('Orders'), findsWidgets);
    await tester.tap(find.byKey(const Key('bottom_nav_0')));
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsWidgets);
  });

  testWidgets('Welcome primary CTA opens shell with Home', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ShopParadiseApp(
        locale: Locale('en'),
        themeMode: ThemeMode.light,
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Browse catalog'));
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsWidgets);
    expect(find.byKey(const Key('bottom_nav_0')), findsOneWidget);
  });

  testWidgets('Welcome secondary arrow opens login dialog', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ShopParadiseApp(
        locale: Locale('en'),
        themeMode: ThemeMode.light,
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.arrow_forward));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('welcome_login_dialog')), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
  });

  testWidgets('Wide layout uses top nav and hides bottom nav', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      const ShopParadiseApp(
        locale: Locale('en'),
        themeMode: ThemeMode.light,
        initialSessionStarted: true,
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(AppTopNav), findsOneWidget);
    expect(find.byType(AppBottomNav), findsNothing);
    await tester.tap(find.byKey(const Key('bottom_nav_3')));
    await tester.pumpAndSettle();
    expect(find.text('Cart'), findsWidgets);
  });
}
