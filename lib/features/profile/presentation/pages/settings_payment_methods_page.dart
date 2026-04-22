import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../payment/presentation/payment_card_option.dart';
import '../../../payment/presentation/payment_demo_cards.dart';
import '../../../payment/presentation/widgets/payment_card_brand_mark.dart';
import '../../../payment/presentation/widgets/payment_card_editor_sheet.dart';
import '../widgets/settings_subpage_header.dart';

/// **Settings** → **Payment methods**: horizontal cards + add / edit sheets.
class SettingsPaymentMethodsPage extends StatefulWidget {
  const SettingsPaymentMethodsPage({super.key});

  @override
  State<SettingsPaymentMethodsPage> createState() =>
      _SettingsPaymentMethodsPageState();
}

class _SettingsPaymentMethodsPageState extends State<SettingsPaymentMethodsPage> {
  late List<PaymentCardOption> _cards;

  @override
  void initState() {
    super.initState();
    _cards = List<PaymentCardOption>.from(kDemoPaymentCards);
  }

  Future<void> _openAdd() async {
    final PaymentCardOption? created = await showPaymentCardEditorSheet(
      context,
    );
    if (created != null && mounted) {
      setState(() => _cards.add(created));
    }
  }

  Future<void> _openEdit(PaymentCardOption card) async {
    final PaymentCardOption? updated = await showPaymentCardEditorSheet(
      context,
      existing: card,
    );
    if (updated != null && mounted) {
      setState(() {
        final int i = _cards.indexWhere(
          (PaymentCardOption c) => c.id == card.id,
        );
        if (i >= 0) {
          _cards[i] = updated;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme scheme = Theme.of(context).colorScheme;
    const double cardWidth = 272;
    const double cardHeight = 168;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SettingsSubpageHeader(subtitle: 'Payment methods'),
            SizedBox(
              height: cardHeight + 24,
              child: ListView(
                key: const Key('settings_payment_horizontal_list'),
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                children: <Widget>[
                  for (final PaymentCardOption card in _cards)
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: _PaymentCardTile(
                        width: cardWidth,
                        height: cardHeight,
                        card: card,
                        onEdit: () => _openEdit(card),
                      ),
                    ),
                  SizedBox(
                    width: 56,
                    height: cardHeight,
                    child: Material(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(16),
                      child: InkWell(
                        key: const Key('settings_payment_add_card'),
                        borderRadius: BorderRadius.circular(16),
                        onTap: _openAdd,
                        child: const Icon(
                          Icons.add_rounded,
                          color: AppColors.onPrimary,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
              child: Text(
                'Saved cards are for this demo only.',
                style: textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentCardTile extends StatelessWidget {
  const _PaymentCardTile({
    required this.width,
    required this.height,
    required this.card,
    required this.onEdit,
  });

  final double width;
  final double height;
  final PaymentCardOption card;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Material(
      color: AppColors.blobLightBlue.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(18),
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onEdit,
        child: SizedBox(
          width: width,
          height: height,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 10, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    PaymentCardBrandMark(isMastercard: card.isMastercard),
                    const Spacer(),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.blobLightBlue,
                        foregroundColor: AppColors.primary,
                      ),
                      onPressed: onEdit,
                      icon: const Icon(Icons.settings_outlined, size: 20),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  card.maskedNumber,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        card.holderName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      card.expiry,
                      style: textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
