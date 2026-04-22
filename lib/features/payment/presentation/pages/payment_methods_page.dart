import 'package:flutter/material.dart';

import '../payment_card_option.dart';
import '../widgets/payment_card_brand_mark.dart';
import 'payment_method_editor_page.dart';

/// Full-screen list of saved cards with add / edit flows (replaces carousel sheet).
class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({
    super.key,
    required this.selectedId,
    this.initialCards,
  });

  final String selectedId;
  final List<PaymentCardOption>? initialCards;

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  static const List<PaymentCardOption> _defaults = <PaymentCardOption>[
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

  late List<PaymentCardOption> _cards;
  late String _selectedId;

  @override
  void initState() {
    super.initState();
    _cards = List<PaymentCardOption>.from(widget.initialCards ?? _defaults);
    _selectedId = _cards.any((PaymentCardOption c) => c.id == widget.selectedId)
        ? widget.selectedId
        : (_cards.isNotEmpty ? _cards.first.id : '');
  }

  PaymentCardOption? _selectedCard() {
    try {
      return _cards.firstWhere((PaymentCardOption c) => c.id == _selectedId);
    } on StateError {
      return _cards.isEmpty ? null : _cards.first;
    }
  }

  void _popWithSelection() {
    final PaymentCardOption? card = _selectedCard();
    if (card != null) {
      Navigator.of(context).pop<PaymentCardOption>(card);
    } else {
      Navigator.of(context).pop();
    }
  }

  Future<void> _openAdd() async {
    final PaymentCardOption? created = await Navigator.of(context)
        .push<PaymentCardOption>(
          MaterialPageRoute<PaymentCardOption>(
            builder: (_) => const PaymentMethodEditorPage(),
          ),
        );
    if (created != null && mounted) {
      setState(() {
        _cards.add(created);
        _selectedId = created.id;
      });
    }
  }

  Future<void> _openEdit(PaymentCardOption card) async {
    final PaymentCardOption? updated = await Navigator.of(context)
        .push<PaymentCardOption>(
          MaterialPageRoute<PaymentCardOption>(
            builder: (_) => PaymentMethodEditorPage(existing: card),
          ),
        );
    if (updated != null && mounted) {
      setState(() {
        final int i = _cards.indexWhere(
          (PaymentCardOption c) => c.id == card.id,
        );
        if (i >= 0) {
          _cards[i] = updated;
        }
        _selectedId = updated.id;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (!didPop) {
          _popWithSelection();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _popWithSelection,
          ),
          title: const Text('Payment methods'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Text(
                'Choose a card for this order. You can add new cards or update saved ones.',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                children: <Widget>[
                  for (final PaymentCardOption card in _cards)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Material(
                        color: colorScheme.surfaceContainerHighest.withValues(
                          alpha: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(14),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: () => setState(() => _selectedId = card.id),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 12, 4, 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Icon(
                                    card.id == _selectedId
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_off,
                                    color: colorScheme.primary,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                PaymentCardBrandMark(
                                  isMastercard: card.isMastercard,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        card.maskedNumber,
                                        style: textTheme.titleSmall?.copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${card.holderName} · ${card.expiry}',
                                        style: textTheme.bodySmall?.copyWith(
                                          color: colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  tooltip: 'Edit',
                                  onPressed: () => _openEdit(card),
                                  icon: Icon(
                                    Icons.edit_outlined,
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: OutlinedButton.icon(
                onPressed: _openAdd,
                icon: const Icon(Icons.add),
                label: const Text('Add payment method'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: FilledButton(
                onPressed: _popWithSelection,
                child: const Text('Use this card'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
