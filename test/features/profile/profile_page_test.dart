import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shop_paradise_kz/features/profile/presentation/pages/order_tracking_page.dart';
import 'package:shop_paradise_kz/features/profile/presentation/pages/profile_page.dart';
import 'package:shop_paradise_kz/features/profile/presentation/pages/vouchers_page.dart';
import 'package:shop_paradise_kz/main.dart';

void main() {
  Future<void> pumpShell(WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      const ProviderScope(
        child: ShopParadiseApp(
          locale: Locale('en'),
          themeMode: ThemeMode.light,
          initialSessionStarted: true,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('Bottom nav opens Profile hub with greeting and sections', (
    WidgetTester tester,
  ) async {
    await pumpShell(tester);
    await tester.tap(find.byKey(const Key('bottom_nav_4')));
    await tester.pumpAndSettle();
    expect(find.byType(ProfilePage), findsOneWidget);
    expect(find.byKey(const Key('profile_greeting')), findsOneWidget);
    expect(find.textContaining('Hello, Amanda'), findsOneWidget);
    expect(find.byKey(const Key('profile_my_orders_section')), findsOneWidget);
    expect(
      find.byKey(const Key('profile_stories_section'), skipOffstage: false),
      findsOneWidget,
    );
  });

  testWidgets('Profile shows voucher summary and opens Vouchers screen', (
    WidgetTester tester,
  ) async {
    await pumpShell(tester);
    await tester.tap(find.byKey(const Key('bottom_nav_4')));
    await tester.pumpAndSettle();
    expect(
      find.byKey(const Key('profile_voucher_summary_card'), skipOffstage: false),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('profile_voucher_summary_title'), skipOffstage: false),
      findsOneWidget,
    );
    expect(
      find.textContaining('expire', skipOffstage: false),
      findsOneWidget,
    );
    await tester.tap(
      find.byKey(const Key('profile_voucher_summary_card'), skipOffstage: false),
    );
    await tester.pumpAndSettle();
    expect(find.byType(VouchersPage), findsOneWidget);
    expect(find.byKey(const Key('vouchers_page_title')), findsOneWidget);
    expect(find.byKey(const Key('vouchers_tab_active_rewards')), findsOneWidget);
    expect(find.byKey(const Key('vouchers_active_list')), findsOneWidget);
    await tester.tap(find.byKey(const Key('vouchers_tab_progress')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('vouchers_progress_grid')), findsOneWidget);
  });

  testWidgets('Profile tab shows voucher reminder badge when mock says so', (
    WidgetTester tester,
  ) async {
    await pumpShell(tester);
    expect(
      find.byKey(const Key('bottom_nav_profile_reminder_badge')),
      findsOneWidget,
    );
  });

  testWidgets('My Activity opens donut and Order History control', (
    WidgetTester tester,
  ) async {
    await pumpShell(tester);
    await tester.tap(find.byKey(const Key('bottom_nav_4')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('profile_my_activity_button')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('profile_activity_title')), findsOneWidget);
    expect(find.byKey(const Key('profile_activity_donut')), findsOneWidget);
    expect(find.byKey(const Key('profile_order_history_button')), findsOneWidget);
  });

  testWidgets('To Receive opens list; Track opens tracking with number', (
    WidgetTester tester,
  ) async {
    await pumpShell(tester);
    await tester.tap(find.byKey(const Key('bottom_nav_4')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('profile_chip_to_receive')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('profile_to_receive_title')), findsOneWidget);
    expect(find.text('Track'), findsWidgets);
    await tester.tap(find.text('Track').first);
    await tester.pumpAndSettle();
    expect(find.byType(OrderTrackingPage), findsOneWidget);
    expect(
      find.byKey(const Key('profile_tracking_number_value')),
      findsOneWidget,
    );
    expect(find.text('LGS-i92927839300763731'), findsOneWidget);
  });
}
