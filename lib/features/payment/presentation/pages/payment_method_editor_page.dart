import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n_helpers.dart';
import '../../../../l10n/app_localizations.dart';
import '../payment_card_option.dart';
import '../widgets/payment_card_form.dart';

/// Add or edit a saved card (mock form — values are not sent to a gateway).
class PaymentMethodEditorPage extends StatelessWidget {
  const PaymentMethodEditorPage({super.key, this.existing});

  final PaymentCardOption? existing;

  bool get isEditing => existing != null;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final String title = isEditing
        ? l10n.paymentEditCardTitle
        : l10n.paymentAddCardTitle;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: PaymentCardForm(
        existing: existing,
        showIntro: true,
        primaryButtonLabel: isEditing
            ? l10n.paymentSaveChanges
            : l10n.paymentAddCardTitle,
        onSubmit: (PaymentCardOption result) {
          Navigator.of(context).pop<PaymentCardOption>(result);
        },
      ),
    );
  }
}
