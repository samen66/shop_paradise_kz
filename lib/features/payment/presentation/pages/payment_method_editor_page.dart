import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../payment_card_option.dart';

/// Add or edit a saved card (mock form — values are not sent to a gateway).
class PaymentMethodEditorPage extends StatefulWidget {
  const PaymentMethodEditorPage({super.key, this.existing});

  final PaymentCardOption? existing;

  bool get isEditing => existing != null;

  @override
  State<PaymentMethodEditorPage> createState() =>
      _PaymentMethodEditorPageState();
}

class _PaymentMethodEditorPageState extends State<PaymentMethodEditorPage> {
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
        label: visa ? 'Visa' : 'Mastercard',
        maskedNumber: masked,
        holderName: _nameCtrl.text.trim().toUpperCase(),
        expiry: _expiryCtrl.text.trim(),
        isMastercard: !visa,
      );
    }
    Navigator.of(context).pop<PaymentCardOption>(result);
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final String title = widget.isEditing ? 'Edit card' : 'Add card';
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          children: <Widget>[
            Text(
              widget.isEditing
                  ? 'Change the name or expiry anytime. Enter a full card number only if you want to replace this card.'
                  : 'Enter your card details. This is a demo — nothing is charged.',
              style: textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            if (widget.isEditing) ...<Widget>[
              const SizedBox(height: 8),
              Text(
                'Current: ${widget.existing!.maskedNumber}',
                style: textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            const SizedBox(height: 24),
            TextFormField(
              controller: _numberCtrl,
              decoration: InputDecoration(
                labelText: 'Card number',
                hintText: widget.isEditing
                    ? 'Leave blank to keep current'
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
                  return 'Enter a valid card number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Name on card',
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.characters,
              validator: (String? v) {
                if (v == null || v.trim().length < 3) {
                  return 'Enter the cardholder name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _expiryCtrl,
              decoration: const InputDecoration(
                labelText: 'Expiry (MM/YY)',
                border: OutlineInputBorder(),
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
                  return 'Use MM/YY';
                }
                final int mm = int.tryParse(d.substring(0, 2)) ?? 0;
                if (mm < 1 || mm > 12) {
                  return 'Invalid month';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _cvvCtrl,
              decoration: const InputDecoration(
                labelText: 'CVV',
                border: OutlineInputBorder(),
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
                  return 'Enter CVV';
                }
                return null;
              },
            ),
            const SizedBox(height: 28),
            FilledButton(
              onPressed: _onSave,
              child: Text(widget.isEditing ? 'Save changes' : 'Add card'),
            ),
          ],
        ),
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
