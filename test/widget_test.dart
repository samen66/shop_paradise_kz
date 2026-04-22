// Smoke tests for app shell, theme, and welcome localization.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shop_paradise_kz/features/cart/presentation/pages/cart_page.dart';
import 'package:shop_paradise_kz/features/home/presentation/widgets/product_card_widget.dart';
import 'package:shop_paradise_kz/features/product_details/presentation/pages/product_details_page.dart';
import 'package:shop_paradise_kz/features/shell/presentation/widgets/app_bottom_nav.dart';
import 'package:shop_paradise_kz/features/shell/presentation/widgets/app_top_nav.dart';
import 'package:shop_paradise_kz/features/wishlist/presentation/pages/wishlist_page.dart';
import 'package:shop_paradise_kz/main.dart';

void main() {
  Future<void> pumpApp(
    WidgetTester tester, {
    required ShopParadiseApp app,
  }) async {
    await tester.pumpWidget(ProviderScope(child: app));
  }

  testWidgets('Welcome shows Russian CTA when locale is ru', (
    WidgetTester tester,
  ) async {
    await pumpApp(
      tester,
      app: const ShopParadiseApp(
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
    await pumpApp(
      tester,
      app: const ShopParadiseApp(
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
    await pumpApp(
      tester,
      app: const ShopParadiseApp(
        locale: Locale('kk'),
        themeMode: ThemeMode.light,
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Каталогты ашу'), findsOneWidget);
    expect(find.text('Paradise'), findsOneWidget);
  });

  testWidgets('Welcome shows brand in dark theme', (WidgetTester tester) async {
    await pumpApp(
      tester,
      app: const ShopParadiseApp(
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
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await pumpApp(
      tester,
      app: const ShopParadiseApp(
        locale: Locale('en'),
        themeMode: ThemeMode.light,
        initialSessionStarted: true,
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(AppBottomNav), findsOneWidget);
    await tester.tap(find.byKey(const Key('bottom_nav_1')));
    await tester.pumpAndSettle();
    expect(find.byType(WishlistPage), findsOneWidget);
    expect(find.text('My Wishlist'), findsOneWidget);
  });

  testWidgets('Bottom nav switches to Cart tab', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await pumpApp(
      tester,
      app: const ShopParadiseApp(
        locale: Locale('en'),
        themeMode: ThemeMode.light,
        initialSessionStarted: true,
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('bottom_nav_3')));
    await tester.pumpAndSettle();
    expect(find.byType(CartPage), findsOneWidget);
    expect(find.text('My cart'), findsOneWidget);
  });

  testWidgets('Bottom nav switches to Orders then back to Home', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await pumpApp(
      tester,
      app: const ShopParadiseApp(
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
    expect(find.text('Search'), findsOneWidget);
  });

  testWidgets('Welcome primary CTA opens shell with Home', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await pumpApp(
      tester,
      app: const ShopParadiseApp(
        locale: Locale('en'),
        themeMode: ThemeMode.light,
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Browse catalog'));
    await tester.pumpAndSettle();
    expect(find.text('Search'), findsOneWidget);
    expect(find.byKey(const Key('bottom_nav_0')), findsOneWidget);
  });

  testWidgets('Welcome secondary arrow opens login dialog', (
    WidgetTester tester,
  ) async {
    await pumpApp(
      tester,
      app: const ShopParadiseApp(
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
    await pumpApp(
      tester,
      app: const ShopParadiseApp(
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

  testWidgets('Tapping product card opens product details page', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await pumpApp(
      tester,
      app: const ShopParadiseApp(
        locale: Locale('en'),
        themeMode: ThemeMode.light,
        initialSessionStarted: true,
      ),
    );
    await tester.pumpAndSettle();
    final Finder firstCard = find.byType(ProductCardWidget).first;
    expect(firstCard, findsOneWidget);
    await tester.tap(firstCard);
    await tester.pumpAndSettle();
    expect(find.byType(ProductDetailsPage), findsOneWidget);
    expect(find.text('Variations'), findsOneWidget);
    expect(find.text('Add to cart'), findsOneWidget);
    expect(find.text('Buy now'), findsOneWidget);
  });
}
