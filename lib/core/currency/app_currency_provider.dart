import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Selected shop currency (ISO 4217). Used for settings and price formatting prefs.
final appCurrencyCodeProvider = StateProvider<String>((Ref ref) => 'USD');

String settingsCurrencyDisplayLabel(String code) {
  switch (code) {
    case 'EUR':
      return '€ EURO';
    case 'VND':
      return '₫ VND';
    case 'RUB':
      return '₽ RUB';
    case 'USD':
      return r'$ USD';
    default:
      return code;
  }
}
