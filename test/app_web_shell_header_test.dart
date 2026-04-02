import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shop_paradise_kz/features/shell/presentation/widgets/app_web_shell_header.dart';
import 'package:shop_paradise_kz/l10n/app_localizations.dart';

void main() {
  testWidgets('AppWebShellHeader exposes brand and catalog keys', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: MediaQuery(
          data: const MediaQueryData(size: Size(1200, 800)),
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 0,
              elevation: 0,
              bottom: AppWebShellHeader(selectedIndex: 0, onSelectTab: (_) {}),
            ),
            body: const SizedBox(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('web_header_brand')), findsOneWidget);
    expect(find.byKey(const Key('web_header_catalog')), findsOneWidget);
  });

  testWidgets('AppWebShellHeader cart icon selects tab 3', (
    WidgetTester tester,
  ) async {
    int? lastIndex;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: MediaQuery(
          data: const MediaQueryData(size: Size(1200, 800)),
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 0,
              elevation: 0,
              bottom: AppWebShellHeader(
                selectedIndex: 0,
                onSelectTab: (int index) {
                  lastIndex = index;
                },
              ),
            ),
            body: const SizedBox(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('web_header_nav_cart')));
    await tester.pumpAndSettle();
    expect(lastIndex, 3);
  });

  testWidgets('AppWebShellHeader brand tap selects tab 0', (
    WidgetTester tester,
  ) async {
    int? lastIndex;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: MediaQuery(
          data: const MediaQueryData(size: Size(1200, 800)),
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 0,
              elevation: 0,
              bottom: AppWebShellHeader(
                selectedIndex: 2,
                onSelectTab: (int index) {
                  lastIndex = index;
                },
              ),
            ),
            body: const SizedBox(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('web_header_brand')));
    await tester.pumpAndSettle();
    expect(lastIndex, 0);
  });
}
