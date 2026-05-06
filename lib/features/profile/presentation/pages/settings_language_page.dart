import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/locale/app_locale_provider.dart';
import '../../../../core/locale/supported_language.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/settings_subpage_header.dart';

const Color _kInactiveLanguageTileBg = Color(0xFFF8F8F8);
const Color _kInactiveLanguageRadioFill = Color(0xFFFAD0D0);

/// **Settings** → **Language**: pick app UI language (Slada-style cards).
///
/// Tiles are derived from [SupportedLanguage.values] so adding a new language
/// is a single-line change in the enum.
class SettingsLanguagePage extends ConsumerWidget {
  const SettingsLanguagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final Locale? selectedLocale = ref.watch(appLocaleProvider);
    final SupportedLanguage? selectedLanguage = selectedLocale == null
        ? null
        : SupportedLanguage.fromCode(selectedLocale.languageCode);

    return Scaffold(
      key: const Key('settings_language_page'),
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 32),
          children: <Widget>[
            SettingsSubpageHeader(subtitle: l10n.languagePageTitle),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  _LanguageOptionTile(
                    key: const Key('settings_language_option_system'),
                    label: l10n.languageFollowSystem,
                    selected: selectedLanguage == null,
                    onTap: () => unawaited(
                      ref
                          .read(appLocaleProvider.notifier)
                          .useSystemLanguage(),
                    ),
                  ),
                  for (final SupportedLanguage language
                      in SupportedLanguage.values) ...<Widget>[
                    const SizedBox(height: 12),
                    _LanguageOptionTile(
                      key: Key('settings_language_option_${language.code}'),
                      label: language.nativeLabel,
                      selected: selectedLanguage == language,
                      onTap: () => unawaited(
                        ref
                            .read(appLocaleProvider.notifier)
                            .setLanguage(language),
                      ),
                    ),
                  ],
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

/// Label shown next to the **Language** row on the Settings hub.
///
/// Returns the language's native label when overridden, or the localized
/// "Follow system" string when the user follows the device locale.
String settingsLanguageDisplayLabel(
  AppLocalizations l10n,
  Locale? overrideLocale,
) {
  if (overrideLocale == null) {
    return l10n.languageFollowSystem;
  }
  final SupportedLanguage? language =
      SupportedLanguage.fromCode(overrideLocale.languageCode);
  return language?.nativeLabel ?? l10n.languageFollowSystem;
}
