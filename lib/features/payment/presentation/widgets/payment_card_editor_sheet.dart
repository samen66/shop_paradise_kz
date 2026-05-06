import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n_helpers.dart';
import '../../../../l10n/app_localizations.dart';
import '../payment_card_option.dart';
import 'payment_card_form.dart';

/// Rounded modal sheet for add/edit card (settings-style).
Future<PaymentCardOption?> showPaymentCardEditorSheet(
  BuildContext context, {
  PaymentCardOption? existing,
}) {
  final bool editing = existing != null;
  return showModalBottomSheet<PaymentCardOption>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext ctx) {
      final AppLocalizations l10n = ctx.l10n;
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(ctx).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 8),
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(ctx).colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  editing ? l10n.paymentEditCardTitle : l10n.paymentAddCardTitle,
                  key: editing
                      ? const Key('edit_card_sheet_title')
                      : const Key('add_card_sheet_title'),
                  style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            PaymentCardForm(
              existing: existing,
              showIntro: false,
              primaryButtonLabel: l10n.paymentSaveChanges,
              onSubmit: (PaymentCardOption r) {
                Navigator.of(ctx).pop(r);
              },
            ),
          ],
        ),
      );
    },
  );
}
