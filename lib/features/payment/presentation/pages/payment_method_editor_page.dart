import 'package:flutter/material.dart';

import '../payment_card_option.dart';
import '../widgets/payment_card_form.dart';

/// Add or edit a saved card (mock form — values are not sent to a gateway).
class PaymentMethodEditorPage extends StatelessWidget {
  const PaymentMethodEditorPage({super.key, this.existing});

  final PaymentCardOption? existing;

  bool get isEditing => existing != null;

  @override
  Widget build(BuildContext context) {
    final String title = isEditing ? 'Edit card' : 'Add card';
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: PaymentCardForm(
        existing: existing,
        showIntro: true,
        primaryButtonLabel: isEditing ? 'Save changes' : 'Add card',
        onSubmit: (PaymentCardOption result) {
          Navigator.of(context).pop<PaymentCardOption>(result);
        },
      ),
    );
  }
}
