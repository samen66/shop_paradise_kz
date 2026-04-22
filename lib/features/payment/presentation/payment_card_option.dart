/// Saved card shown at checkout (mock / UI model — no real PAN storage).
class PaymentCardOption {
  const PaymentCardOption({
    required this.id,
    required this.label,
    required this.maskedNumber,
    required this.holderName,
    required this.expiry,
    required this.isMastercard,
  });

  final String id;
  final String label;
  final String maskedNumber;
  final String holderName;
  final String expiry;
  final bool isMastercard;

  String get lastFour {
    final String digits = maskedNumber.replaceAll(RegExp(r'\D'), '');
    if (digits.length >= 4) {
      return digits.substring(digits.length - 4);
    }
    return '';
  }

  String get summaryLabel {
    final String brand = isMastercard ? 'Mastercard' : 'Visa';
    final String four = lastFour;
    if (four.isEmpty) {
      return brand;
    }
    return '$brand •••• $four';
  }

  PaymentCardOption copyWith({
    String? id,
    String? label,
    String? maskedNumber,
    String? holderName,
    String? expiry,
    bool? isMastercard,
  }) {
    return PaymentCardOption(
      id: id ?? this.id,
      label: label ?? this.label,
      maskedNumber: maskedNumber ?? this.maskedNumber,
      holderName: holderName ?? this.holderName,
      expiry: expiry ?? this.expiry,
      isMastercard: isMastercard ?? this.isMastercard,
    );
  }
}
