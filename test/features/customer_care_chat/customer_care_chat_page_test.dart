import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shop_paradise_kz/features/customer_care_chat/presentation/pages/customer_care_chat_page.dart';
import 'package:shop_paradise_kz/features/orders/domain/entities/order_entities.dart';
import 'package:shop_paradise_kz/features/orders/domain/repositories/orders_repository.dart';
import 'package:shop_paradise_kz/features/orders/presentation/providers/orders_providers.dart';
import 'package:shop_paradise_kz/l10n/app_localizations.dart';

void main() {
  testWidgets('customer care opens category sheet with localized title',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          ordersRepositoryProvider.overrideWithValue(_EmptyOrdersRepository()),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale('en'),
          home: CustomerCareChatPage(displayName: 'Amanda'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text("What's your issue?"), findsOneWidget);
    expect(find.text('Order Issues'), findsOneWidget);
  });
}

class _EmptyOrdersRepository implements OrdersRepository {
  @override
  Future<List<OrderSummaryEntity>> getOrders() async => <OrderSummaryEntity>[];
}
