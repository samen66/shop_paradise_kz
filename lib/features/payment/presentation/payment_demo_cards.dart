import 'payment_card_option.dart';

/// Default saved cards for checkout and settings demos.
const List<PaymentCardOption> kDemoPaymentCards = <PaymentCardOption>[
  PaymentCardOption(
    id: 'mc_1579',
    label: 'Mastercard',
    maskedNumber: '****  ****  ****  1579',
    holderName: 'AMANDA MORGAN',
    expiry: '12/22',
    isMastercard: true,
  ),
  PaymentCardOption(
    id: 'visa_8821',
    label: 'Visa',
    maskedNumber: '****  ****  ****  8821',
    holderName: 'AMANDA MORGAN',
    expiry: '08/24',
    isMastercard: false,
  ),
];
