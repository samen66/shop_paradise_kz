import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/currency/app_currency_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/settings_subpage_header.dart';

const Color _kInactiveCurrencyTileBg = Color(0xFFF8F8F8);
const Color _kInactiveCurrencyRadioFill = Color(0xFFFAD0D0);

/// **Settings** → **Currency**: pick display currency (Slada-style cards).
class SettingsCurrencyPage extends ConsumerWidget {
  const SettingsCurrencyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String selected = ref.watch(appCurrencyCodeProvider);

    return Scaffold(
      key: const Key('settings_currency_page'),
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 32),
          children: <Widget>[
            const SettingsSubpageHeader(subtitle: 'Currency'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  _CurrencyOptionTile(
                    key: const Key('settings_currency_option_usd'),
                    label: r'$ USD',
                    selected: selected == 'USD',
                    onTap: () {
                      ref.read(appCurrencyCodeProvider.notifier).state = 'USD';
                    },
                  ),
                  const SizedBox(height: 12),
                  _CurrencyOptionTile(
                    key: const Key('settings_currency_option_eur'),
                    label: '€ EURO',
                    selected: selected == 'EUR',
                    onTap: () {
                      ref.read(appCurrencyCodeProvider.notifier).state = 'EUR';
                    },
                  ),
                  const SizedBox(height: 12),
                  _CurrencyOptionTile(
                    key: const Key('settings_currency_option_vnd'),
                    label: '₫ VND',
                    selected: selected == 'VND',
                    onTap: () {
                      ref.read(appCurrencyCodeProvider.notifier).state = 'VND';
                    },
                  ),
                  const SizedBox(height: 12),
                  _CurrencyOptionTile(
                    key: const Key('settings_currency_option_rub'),
                    label: '₽ RUB',
                    selected: selected == 'RUB',
                    onTap: () {
                      ref.read(appCurrencyCodeProvider.notifier).state = 'RUB';
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CurrencyOptionTile extends StatelessWidget {
  const _CurrencyOptionTile({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Material(
      color: selected ? AppColors.blobLightBlue : _kInactiveCurrencyTileBg,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  label,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurface,
                  ),
                ),
              ),
              if (selected)
                Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: AppColors.onPrimary,
                    size: 18,
                  ),
                )
              else
                Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: _kInactiveCurrencyRadioFill,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
