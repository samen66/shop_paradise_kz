import 'package:flutter/material.dart';

const Set<String> _paymentAddressCountries = <String>{
  'India',
  'Kazakhstan',
  'Vietnam',
  'United States',
  'United Kingdom',
};

/// Bottom sheet matching Shoppe-style **Shipping Address**: country row,
/// separate street / town / postcode fields, pale filled inputs, **Save Changes**.
class PaymentShippingAddressSheet extends StatefulWidget {
  const PaymentShippingAddressSheet({super.key, required this.initialAddress});

  /// Last saved single- or multi-line address; shown in **Address** when not parsed.
  final String initialAddress;

  @override
  State<PaymentShippingAddressSheet> createState() =>
      _PaymentShippingAddressSheetState();
}

class _PaymentShippingAddressSheetState
    extends State<PaymentShippingAddressSheet> {
  static const List<String> _countries = <String>[
    'India',
    'Kazakhstan',
    'Vietnam',
    'United States',
    'United Kingdom',
  ];

  late String _country;
  late final TextEditingController _addressLine;
  late final TextEditingController _townCity;
  late final TextEditingController _postcode;

  @override
  void initState() {
    super.initState();
    final _ParsedAddress parsed = _ParsedAddress.fromFull(
      widget.initialAddress,
    );
    _country =
        (parsed.country != null &&
            _paymentAddressCountries.contains(parsed.country))
        ? parsed.country!
        : 'India';
    _addressLine = TextEditingController(text: parsed.street);
    _townCity = TextEditingController(text: parsed.townCity);
    _postcode = TextEditingController(text: parsed.postcode);
  }

  @override
  void dispose() {
    _addressLine.dispose();
    _townCity.dispose();
    _postcode.dispose();
    super.dispose();
  }

  Color _inputFillColor(ColorScheme scheme) {
    return Color.alphaBlend(
      scheme.primary.withValues(alpha: 0.07),
      scheme.surfaceContainerHighest.withValues(alpha: 0.5),
    );
  }

  Future<void> _pickCountry() async {
    final String? picked = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Country',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              ..._countries.map((String c) {
                return ListTile(
                  title: Text(c),
                  trailing: c == _country
                      ? Icon(
                          Icons.check,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : null,
                  onTap: () => Navigator.of(context).pop<String>(c),
                );
              }),
            ],
          ),
        );
      },
    );
    if (picked != null) {
      setState(() => _country = picked);
    }
  }

  String _composeSavedAddress() {
    return <String>[
      if (_addressLine.text.trim().isNotEmpty) _addressLine.text.trim(),
      if (_townCity.text.trim().isNotEmpty) _townCity.text.trim(),
      if (_postcode.text.trim().isNotEmpty) _postcode.text.trim(),
      _country,
    ].join('\n');
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final double inset = MediaQuery.viewInsetsOf(context).bottom;
    final Color fill = _inputFillColor(colorScheme);
    final TextStyle labelStyle = textTheme.labelLarge!.copyWith(
      color: colorScheme.onSurface,
      fontWeight: FontWeight.w600,
    );
    final TextStyle countryValueStyle = textTheme.bodyLarge!.copyWith(
      color: colorScheme.onSurfaceVariant,
    );

    return Padding(
      padding: EdgeInsets.only(bottom: inset),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            Text(
              'Shipping Address',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 20),
            Text('Country', style: labelStyle),
            const SizedBox(height: 8),
            InkWell(
              onTap: _pickCountry,
              borderRadius: BorderRadius.circular(14),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: <Widget>[
                    Expanded(child: Text(_country, style: countryValueStyle)),
                    Material(
                      color: colorScheme.surfaceContainerHighest,
                      shape: const CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          Icons.chevron_right_rounded,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            _LabeledFilledField(
              label: 'Address',
              controller: _addressLine,
              fillColor: fill,
              colorScheme: colorScheme,
              labelStyle: labelStyle,
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            _LabeledFilledField(
              label: 'Town / City',
              controller: _townCity,
              fillColor: fill,
              colorScheme: colorScheme,
              labelStyle: labelStyle,
            ),
            const SizedBox(height: 16),
            _LabeledFilledField(
              label: 'Postcode',
              controller: _postcode,
              fillColor: fill,
              colorScheme: colorScheme,
              labelStyle: labelStyle,
              keyboardType: TextInputType.number,
              textCapitalization: TextCapitalization.none,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop<String>(_composeSavedAddress());
              },
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}

class _LabeledFilledField extends StatelessWidget {
  const _LabeledFilledField({
    required this.label,
    required this.controller,
    required this.fillColor,
    required this.colorScheme,
    required this.labelStyle,
    this.maxLines = 1,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.sentences,
  });

  final String label;
  final TextEditingController controller;
  final Color fillColor;
  final ColorScheme colorScheme;
  final TextStyle labelStyle;
  final int maxLines;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: labelStyle),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          decoration: InputDecoration(
            filled: true,
            fillColor: fillColor,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: colorScheme.outlineVariant.withValues(alpha: 0.35),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: colorScheme.outlineVariant.withValues(alpha: 0.35),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

class _ParsedAddress {
  const _ParsedAddress({
    this.country,
    required this.street,
    required this.townCity,
    required this.postcode,
  });

  final String? country;
  final String street;
  final String townCity;
  final String postcode;

  /// Saved form: street, town, postcode, country (each line optional except country).
  factory _ParsedAddress.fromFull(String full) {
    const _ParsedAddress designDefault = _ParsedAddress(
      street: 'Magadi Main Rd, next to Prasanna Theatre, C',
      townCity: 'Bengaluru, Karnataka 560023',
      postcode: '70000',
    );
    final String t = full.trim();
    if (t.isEmpty) {
      return designDefault;
    }
    final List<String> lines = t
        .split(RegExp(r'\r?\n'))
        .map((String s) => s.trim())
        .where((String s) => s.isNotEmpty)
        .toList();
    if (lines.isEmpty) {
      return designDefault;
    }
    final List<String> parts = List<String>.from(lines);
    String? parsedCountry;
    if (_paymentAddressCountries.contains(parts.last)) {
      parsedCountry = parts.removeLast();
    }
    if (parts.isEmpty) {
      return _ParsedAddress(
        country: parsedCountry,
        street: '',
        townCity: '',
        postcode: '',
      );
    }
    if (parts.length == 1) {
      return _ParsedAddress(
        country: parsedCountry,
        street: parts[0],
        townCity: '',
        postcode: '',
      );
    }
    if (parts.length == 2) {
      return _ParsedAddress(
        country: parsedCountry,
        street: parts[0],
        townCity: parts[1],
        postcode: '',
      );
    }
    final String postcode = parts.removeLast();
    final String town = parts.removeLast();
    final String street = parts.join('\n');
    return _ParsedAddress(
      country: parsedCountry,
      street: street,
      townCity: town,
      postcode: postcode,
    );
  }
}

class PaymentContactResult {
  const PaymentContactResult({required this.phone, required this.email});

  final String phone;
  final String email;
}

class PaymentContactEditSheet extends StatefulWidget {
  const PaymentContactEditSheet({
    super.key,
    required this.initialPhone,
    required this.initialEmail,
  });

  final String initialPhone;
  final String initialEmail;

  @override
  State<PaymentContactEditSheet> createState() =>
      _PaymentContactEditSheetState();
}

class _PaymentContactEditSheetState extends State<PaymentContactEditSheet> {
  late final TextEditingController _phone = TextEditingController(
    text: widget.initialPhone,
  );
  late final TextEditingController _email = TextEditingController(
    text: widget.initialEmail,
  );

  @override
  void dispose() {
    _phone.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double inset = MediaQuery.viewInsetsOf(context).bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: inset),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            Text(
              'Contact Information',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phone,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone',
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop<PaymentContactResult>(
                  PaymentContactResult(
                    phone: _phone.text.trim(),
                    email: _email.text.trim(),
                  ),
                );
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
