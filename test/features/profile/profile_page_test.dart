import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shop_paradise_kz/core/prefs/app_preferences_keys.dart';
import 'package:shop_paradise_kz/core/prefs/shared_preferences_provider.dart';
import 'package:shop_paradise_kz/features/profile/presentation/pages/order_tracking_page.dart';
import 'package:shop_paradise_kz/features/profile/presentation/pages/profile_page.dart';
import 'package:shop_paradise_kz/features/profile/presentation/pages/settings_currency_page.dart';
import 'package:shop_paradise_kz/features/profile/presentation/pages/settings_page.dart';
import 'package:shop_paradise_kz/features/profile/presentation/pages/vouchers_page.dart';
import 'package:shop_paradise_kz/main.dart';

void main() {
  Future<void> pumpShell(WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    SharedPreferences.setMockInitialValues(<String, Object>{
      AppPreferencesKeys.onboardingCompleted: true,
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
        child: const ShopParadiseApp(
          locale: Locale('en'),
          themeMode: ThemeMode.light,
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Browse catalog'));
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

  testWidgets('Settings opens from header gear; profile save updates greeting', (
    WidgetTester tester,
  ) async {
    await pumpShell(tester);
    await tester.tap(find.byKey(const Key('bottom_nav_4')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('profile_header_settings')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('settings_page')), findsOneWidget);
    expect(find.byType(SettingsPage), findsOneWidget);
    await tester.tap(find.byKey(const Key('settings_tile_profile')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('settings_profile_name_field')),
      'Zoe',
    );
    await tester.tap(find.byKey(const Key('settings_profile_save_button')));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();
    expect(find.textContaining('Hello, Zoe'), findsOneWidget);
  });

  testWidgets('Settings payment methods opens Add card bottom sheet', (
    WidgetTester tester,
  ) async {
    await pumpShell(tester);
    await tester.tap(find.byKey(const Key('bottom_nav_4')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('profile_header_settings')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('settings_tile_payment_methods')));
    await tester.pumpAndSettle();
    await tester.drag(
      find.byKey(const Key('settings_payment_horizontal_list')),
      const Offset(-400, 0),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('settings_payment_add_card')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('add_card_sheet_title')), findsOneWidget);
  });

  testWidgets('Settings currency opens picker and updates hub row', (
    WidgetTester tester,
  ) async {
    await pumpShell(tester);
    await tester.tap(find.byKey(const Key('bottom_nav_4')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('profile_header_settings')));
    await tester.pumpAndSettle();
    expect(find.text(r'$ USD'), findsOneWidget);
    await tester.tap(find.byKey(const Key('settings_tile_currency')));
    await tester.pumpAndSettle();
    expect(find.byType(SettingsCurrencyPage), findsOneWidget);
    await tester.tap(find.byKey(const Key('settings_currency_option_eur')));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();
    expect(find.text('€ EURO'), findsOneWidget);
  });

  testWidgets('Settings opens shipping address screen', (
    WidgetTester tester,
  ) async {
    await pumpShell(tester);
    await tester.tap(find.byKey(const Key('bottom_nav_4')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('profile_header_settings')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('settings_tile_shipping_address')));
    await tester.pumpAndSettle();
    expect(find.text('Choose your country'), findsOneWidget);
    expect(find.byKey(const Key('settings_shipping_save_button')), findsOneWidget);
  });
}
