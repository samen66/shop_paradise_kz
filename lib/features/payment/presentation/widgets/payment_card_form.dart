import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/l10n/l10n_helpers.dart';
import '../../../../l10n/app_localizations.dart';
import '../payment_card_option.dart';

/// Shared add/edit card form (mock — not sent to a gateway).
class PaymentCardForm extends StatefulWidget {
  const PaymentCardForm({
    super.key,
    this.existing,
    required this.onSubmit,
    this.showIntro = true,
    required this.primaryButtonLabel,
  });

  final PaymentCardOption? existing;
  final void Function(PaymentCardOption result) onSubmit;
  final bool showIntro;
  final String primaryButtonLabel;

  bool get isEditing => existing != null;

  @override
  State<PaymentCardForm> createState() => _PaymentCardFormState();
}

class _PaymentCardFormState extends State<PaymentCardForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _numberCtrl;
  late final TextEditingController _nameCtrl;
  late final TextEditingController _expiryCtrl;
  late final TextEditingController _cvvCtrl;

  @override
  void initState() {
    super.initState();
    final PaymentCardOption? e = widget.existing;
    _numberCtrl = TextEditingController();
    _nameCtrl = TextEditingController(text: e?.holderName ?? '');
    _expiryCtrl = TextEditingController(text: e?.expiry ?? '');
    _cvvCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _numberCtrl.dispose();
    _nameCtrl.dispose();
    _expiryCtrl.dispose();
    _cvvCtrl.dispose();
    super.dispose();
  }

  static String _digitsOnly(String s) => s.replaceAll(RegExp(r'\D'), '');

  static bool _isVisaPan(String digits) =>
      digits.isNotEmpty && digits.codeUnitAt(0) == 52; // '4'

  void _onSave() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    final AppLocalizations l10n = context.l10n;
    final PaymentCardOption? e = widget.existing;
    final String digits = _digitsOnly(_numberCtrl.text);
    final PaymentCardOption result;
    if (e != null && digits.isEmpty) {
      result = e.copyWith(
        holderName: _nameCtrl.text.trim().toUpperCase(),
        expiry: _expiryCtrl.text.trim(),
      );
    } else {
      final String last4 = digits.length >= 4
          ? digits.substring(digits.length - 4)
          : digits;
      final String masked = '****  ****  ****  $last4';
      final bool visa = _isVisaPan(digits);
      result = PaymentCardOption(
        id: e?.id ?? 'card_${DateTime.now().millisecondsSinceEpoch}',
        label: visa ? l10n.paymentBrandVisa : l10n.paymentBrandMastercard,
        maskedNumber: masked,
        holderName: _nameCtrl.text.trim().toUpperCase(),
        expiry: _expiryCtrl.text.trim(),
        isMastercard: !visa,
      );
    }
    widget.onSubmit(result);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: <Widget>[
          if (widget.showIntro) ...<Widget>[
            Text(
              widget.isEditing
                  ? l10n.paymentCardIntroEdit
                  : l10n.paymentCardIntroAdd,
              style: textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            if (widget.isEditing) ...<Widget>[
              const SizedBox(height: 8),
              Text(
                l10n.paymentCardCurrentMasked(widget.existing!.maskedNumber),
                style: textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            const SizedBox(height: 24),
          ],
          TextFormField(
            controller: _numberCtrl,
            decoration: InputDecoration(
              labelText: l10n.paymentCardNumberLabel,
              hintText: widget.isEditing
                  ? l10n.paymentCardNumberHintKeep
                  : null,
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(19),
              _CardSpacingFormatter(),
            ],
            validator: (String? v) {
              final String d = _digitsOnly(v ?? '');
              if (widget.isEditing && d.isEmpty) {
                return null;
              }
              if (d.length < 13 || d.length > 19) {
                return l10n.paymentCardNumberError;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _nameCtrl,
            decoration: InputDecoration(
              labelText: l10n.paymentCardHolderLabel,
              border: const OutlineInputBorder(),
            ),
            textCapitalization: TextCapitalization.characters,
            validator: (String? v) {
              if (v == null || v.trim().length < 3) {
                return l10n.paymentCardHolderError;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _expiryCtrl,
            decoration: InputDecoration(
              labelText: l10n.paymentCardExpiryLabel,
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(4),
              _ExpiryFormatter(),
            ],
            validator: (String? v) {
              final String d = _digitsOnly(v ?? '');
              if (d.length != 4) {
                return l10n.paymentCardExpiryFormatError;
              }
              final int mm = int.tryParse(d.substring(0, 2)) ?? 0;
              if (mm < 1 || mm > 12) {
                return l10n.paymentCardExpiryMonthError;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _cvvCtrl,
            decoration: InputDecoration(
              labelText: l10n.paymentCardCvvLabel,
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            obscureText: true,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(4),
            ],
            validator: (String? v) {
              final String d = _digitsOnly(v ?? '');
              if (d.length < 3) {
                return l10n.paymentCardCvvError;
              }
              return null;
            },
          ),
          const SizedBox(height: 28),
          FilledButton(
            onPressed: _onSave,
            child: Text(widget.primaryButtonLabel),
          ),
        ],
      ),
    );
  }
}

class _CardSpacingFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final StringBuffer buf = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buf.write(' ');
      }
      buf.write(digits[i]);
    }
    final String text = buf.toString();
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class _ExpiryFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) {
      return const TextEditingValue();
    }
    String text = digits.substring(0, digits.length.clamp(0, 4));
    if (text.length >= 2) {
      text = '${text.substring(0, 2)}/${text.substring(2)}';
    }
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
