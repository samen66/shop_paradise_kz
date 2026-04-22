import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/locale/app_locale_override_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/settings_subpage_header.dart';

const Color _kInactiveLanguageTileBg = Color(0xFFF8F8F8);
const Color _kInactiveLanguageRadioFill = Color(0xFFFAD0D0);

/// **Settings** → **Language**: pick app UI language (Slada-style cards).
class SettingsLanguagePage extends ConsumerWidget {
  const SettingsLanguagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Locale effectiveLocale = Localizations.localeOf(context);
    final String selectedCode = effectiveLocale.languageCode;

    return Scaffold(
      key: const Key('settings_language_page'),
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 32),
          children: <Widget>[
            const SettingsSubpageHeader(subtitle: 'Language'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  _LanguageOptionTile(
                    key: const Key('settings_language_option_en'),
                    label: 'English',
                    selected: selectedCode == 'en',
                    onTap: () {
                      ref.read(appLocaleOverrideProvider.notifier).state =
                          const Locale('en');
                    },
                  ),
                  const SizedBox(height: 12),
                  _LanguageOptionTile(
                    key: const Key('settings_language_option_kk'),
                    label: 'Қазақша',
                    selected: selectedCode == 'kk',
                    onTap: () {
                      ref.read(appLocaleOverrideProvider.notifier).state =
                          const Locale('kk');
                    },
                  ),
                  const SizedBox(height: 12),
                  _LanguageOptionTile(
                    key: const Key('settings_language_option_fr'),
                    label: 'Français',
                    selected: false,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'French is not available yet — try English or Russian.',
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _LanguageOptionTile(
                    key: const Key('settings_language_option_ru'),
                    label: 'Русский',
                    selected: selectedCode == 'ru',
                    onTap: () {
                      ref.read(appLocaleOverrideProvider.notifier).state =
                          const Locale('ru');
                    },
                  ),
                  const SizedBox(height: 12),
                  _LanguageOptionTile(
                    key: const Key('settings_language_option_vi'),
                    label: 'Tiếng Việt',
                    selected: false,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Vietnamese is not available yet — try English or Russian.',
                          ),
                        ),
                      );
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

class _LanguageOptionTile extends StatelessWidget {
  const _LanguageOptionTile({
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
      color: selected ? AppColors.blobLightBlue : _kInactiveLanguageTileBg,
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
                    color: _kInactiveLanguageRadioFill,
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

String settingsLanguageDisplayLabel(Locale locale) {
  switch (locale.languageCode) {
    case 'en':
      return 'English';
    case 'kk':
      return 'Қазақша';
    case 'ru':
      return 'Русский';
    default:
      return 'English';
  }
}
