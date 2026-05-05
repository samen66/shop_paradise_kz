// Generates PNGs for README via: flutter test test/readme_screenshots_test.dart
// --update-goldens

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_paradise_kz/features/shopping_notes/domain/entities/shopping_note_entity.dart';
import 'package:shop_paradise_kz/features/shopping_notes/domain/entities/spending_category_entity.dart';
import 'package:shop_paradise_kz/features/shopping_notes/presentation/pages/shopping_notes_page.dart';
import 'package:shop_paradise_kz/features/shopping_notes/presentation/pages/spending_analytics_page.dart';
import 'package:shop_paradise_kz/features/shopping_notes/presentation/providers/shopping_notes_providers.dart';
import 'package:shop_paradise_kz/features/welcome/presentation/welcome_page.dart';
import 'package:shop_paradise_kz/l10n/app_localizations.dart';

void main() {
  Future<void> pumpSize(WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  testWidgets('readme golden 01 welcome', (WidgetTester tester) async {
    await pumpSize(tester);
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light(useMaterial3: true),
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: WelcomePage(onContinueToShop: () {}),
      ),
    );
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('../docs/screenshots/01_welcome.png'),
    );
  });

  testWidgets('readme golden 02 shopping notes', (WidgetTester tester) async {
    await pumpSize(tester);
    final GoRouter router = GoRouter(
      initialLocation: '/notes',
      routes: <RouteBase>[
        GoRoute(
          path: '/notes',
          builder: (BuildContext context, GoRouterState state) {
            return const ShoppingNotesPage();
          },
        ),
        GoRoute(
          path: '/analytics',
          builder: (BuildContext context, GoRouterState state) {
            return const SpendingAnalyticsPage();
          },
        ),
      ],
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          shoppingNotesStreamProvider.overrideWith(
            (Ref ref) => Stream<List<ShoppingNoteEntity>>.value(
              const <ShoppingNoteEntity>[],
            ),
          ),
          spendingCategoriesStreamProvider.overrideWith(
            (Ref ref) => Stream<List<SpendingCategoryEntity>>.value(
              const <SpendingCategoryEntity>[],
            ),
          ),
          connectivityStreamProvider.overrideWith(
            (Ref ref) => Stream<bool>.value(true),
          ),
        ],
        child: MaterialApp.router(
          theme: ThemeData.light(useMaterial3: true),
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('../docs/screenshots/02_shopping_notes.png'),
    );
  });

  testWidgets('readme golden 03 spending analytics', (
    WidgetTester tester,
  ) async {
    await pumpSize(tester);
    final DateTime now = DateTime.utc(2025, 6, 1);
    final List<ShoppingNoteEntity> notes = <ShoppingNoteEntity>[
      ShoppingNoteEntity(
        id: 1,
        title: 'Milk',
        body: '',
        category: 'Groceries',
        categoryId: 1,
        amount: 12.5,
        syncedToRemote: false,
        createdAt: now,
        updatedAt: now,
      ),
      ShoppingNoteEntity(
        id: 2,
        title: 'Notebook',
        body: '',
        category: 'Other',
        categoryId: 2,
        amount: 24,
        syncedToRemote: false,
        createdAt: now,
        updatedAt: now,
      ),
    ];
    final GoRouter router = GoRouter(
      initialLocation: '/analytics',
      routes: <RouteBase>[
        GoRoute(
          path: '/notes',
          builder: (BuildContext context, GoRouterState state) {
            return const ShoppingNotesPage();
          },
        ),
        GoRoute(
          path: '/analytics',
          builder: (BuildContext context, GoRouterState state) {
            return const SpendingAnalyticsPage();
          },
        ),
      ],
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          shoppingNotesStreamProvider.overrideWith(
            (Ref ref) => Stream<List<ShoppingNoteEntity>>.value(notes),
          ),
          spendingCategoriesStreamProvider.overrideWith(
            (Ref ref) => Stream<List<SpendingCategoryEntity>>.value(
              const <SpendingCategoryEntity>[],
            ),
          ),
          connectivityStreamProvider.overrideWith(
            (Ref ref) => Stream<bool>.value(true),
          ),
        ],
        child: MaterialApp.router(
          theme: ThemeData.light(useMaterial3: true),
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('../docs/screenshots/03_spending_analytics.png'),
    );
  });
}
