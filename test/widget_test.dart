// Basic smoke test for the app shell and theme.

import 'package:flutter_test/flutter_test.dart';

import 'package:shop_paradise_kz/main.dart';

void main() {
  testWidgets('App shows title and theme preview', (WidgetTester tester) async {
    await tester.pumpWidget(const ShopParadiseApp());
    expect(find.text('Shop Paradise'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
}
