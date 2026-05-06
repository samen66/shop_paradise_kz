import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/currency/app_currency_provider.dart';
import '../../../../core/locale/app_locale_provider.dart';
import '../../../../core/notifications/daily_reminder_provider.dart';
import '../../../../core/session/session_started_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_mode_provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/presentation/auth_providers.dart';
import '../../../customer_care_chat/presentation/pages/customer_care_chat_page.dart';
import '../../domain/entities/profile_entities.dart';
import '../providers/profile_providers.dart';
import 'settings_currency_page.dart';
import 'settings_language_page.dart';
import 'settings_payment_methods_page.dart';
import 'settings_profile_page.dart';
import 'settings_shipping_address_page.dart';

const String _kAppDisplayName = 'Shop Paradise';
const String _kAppVersion = '1.0.0';
const String _kAppBuildDate = 'April, 2026';
const String _kSettingsCountryDemoValue = 'Vietnam';
const String _kSettingsSizesDemoValue = 'UK';

/// Confirms sign-out, clears Google + Firebase sessions, returns to Welcome.
Future<void> _confirmLogoutFromSettings(
  BuildContext context,
  WidgetRef ref,
  AppLocalizations l10n,
) async {
  final bool? ok = await showDialog<bool>(
    context: context,
    builder: (BuildContext ctx) => AlertDialog(
      title: Text(l10n.settingsLogoutTitle),
      content: Text(l10n.settingsLogoutMessage),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(false),
          child: Text(l10n.commonCancel),
        ),
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(true),
          child: Text(l10n.commonLogout),
        ),
      ],
    ),
  );
  if (ok != true || !context.mounted) {
    return;
  }
  if (Firebase.apps.isNotEmpty) {
    try {
      await GoogleSignIn.instance.signOut();
    } on Object {
      // Best-effort; Firebase sign-out still runs.
    }
    await FirebaseAuth.instance.signOut();
  }
  ref.read(sessionStartedProvider.notifier).state = false;
  if (!context.mounted) {
    return;
  }
  context.go('/welcome');
}

/// Opens the settings hub from anywhere in the app (profile tab flows).
void openAppSettings(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => const SettingsPage()),
  );
}

/// Root settings hub: Personal, Shop, Account, footer (Slada-style layout).
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  void _comingSoon(
    BuildContext context,
    AppLocalizations l10n,
    String feature,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.settingsComingSoonMessage(feature))),
    );
  }

  Future<void> _confirmDeleteAccount(
    BuildContext context,
    AppLocalizations l10n,
  ) async {
    final bool? ok = await showDialog<bool>(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        title: Text(l10n.settingsDeleteAccountTitle),
        content: Text(l10n.settingsDeleteAccountMessage),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(l10n.commonDelete),
          ),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.settingsDeleteAccountDemoMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final Locale? overrideLocale = ref.watch(appLocaleProvider);
    final String currencyCode = ref.watch(appCurrencyCodeProvider);
    final User? signedInUser = ref.watch(authStateProvider).valueOrNull;

    final ThemeMode themeMode = ref.watch(themeModeProvider);
    final bool reminderOn = ref.watch(dailyReminderEnabledProvider);
    return Scaffold(
      key: const Key('settings_page'),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 32),
          children: <Widget>[
            _SettingsPageHeader(title: l10n.settingsTitle),
            const SizedBox(height: 8),
            _SectionTitle(text: l10n.settingsSectionPersonal),
            _SettingsRow(
              key: const Key('settings_tile_profile'),
              label: l10n.settingsRowProfile,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const SettingsProfilePage(),
                  ),
                );
              },
            ),
            _Divider(color: scheme.outlineVariant),
            _SettingsRow(
              key: const Key('settings_tile_shipping_address'),
              label: l10n.settingsRowShippingAddress,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const SettingsShippingAddressPage(),
                  ),
                );
              },
            ),
            _Divider(color: scheme.outlineVariant),
            _SettingsRow(
              key: const Key('settings_tile_payment_methods'),
              label: l10n.settingsRowPaymentMethods,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const SettingsPaymentMethodsPage(),
                  ),
                );
              },
            ),
            _Divider(color: scheme.outlineVariant),
            _SectionTitle(text: l10n.settingsSectionShop),
            _SettingsRow(
              key: const Key('settings_tile_shopping_notes'),
              label: l10n.settingsRowShoppingNotes,
              onTap: () => context.push('/notes'),
            ),
            _Divider(color: scheme.outlineVariant),
            _SettingsRow(
              key: const Key('settings_tile_spending_chart'),
              label: l10n.settingsRowSpendingChart,
              onTap: () => context.push('/analytics'),
            ),
            _Divider(color: scheme.outlineVariant),
            _SettingsRow(
              key: const Key('settings_tile_country'),
              label: l10n.settingsRowCountry,
              value: _kSettingsCountryDemoValue,
              onTap: () => _comingSoon(context, l10n, l10n.settingsRowCountry),
            ),
            _Divider(color: scheme.outlineVariant),
            _SettingsRow(
              key: const Key('settings_tile_currency'),
              label: l10n.settingsRowCurrency,
              value: settingsCurrencyDisplayLabel(currencyCode),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const SettingsCurrencyPage(),
                  ),
                );
              },
            ),
            _Divider(color: scheme.outlineVariant),
            _SettingsRow(
              key: const Key('settings_tile_sizes'),
              label: l10n.settingsRowSizes,
              value: _kSettingsSizesDemoValue,
              onTap: () => _comingSoon(context, l10n, l10n.settingsRowSizes),
            ),
            _Divider(color: scheme.outlineVariant),
            _SettingsRow(
              key: const Key('settings_tile_terms'),
              label: l10n.settingsRowTerms,
              onTap: () => _comingSoon(context, l10n, l10n.settingsRowTerms),
            ),
            _Divider(color: scheme.outlineVariant),
            _SectionTitle(text: l10n.settingsThemeSection),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: DropdownButton<ThemeMode>(
                isExpanded: true,
                value: themeMode,
                items: <DropdownMenuItem<ThemeMode>>[
                  DropdownMenuItem<ThemeMode>(
                    value: ThemeMode.system,
                    child: Text(l10n.themeModeSystem),
                  ),
                  DropdownMenuItem<ThemeMode>(
                    value: ThemeMode.light,
                    child: Text(l10n.themeModeLight),
                  ),
                  DropdownMenuItem<ThemeMode>(
                    value: ThemeMode.dark,
                    child: Text(l10n.themeModeDark),
                  ),
                ],
                onChanged: (ThemeMode? next) {
                  if (next != null) {
                    unawaited(
                      ref.read(themeModeProvider.notifier).setThemeMode(next),
                    );
                  }
                },
              ),
            ),
            _Divider(color: scheme.outlineVariant),
            SwitchListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              title: Text(l10n.settingsDailyReminderTitle),
              subtitle: Text(l10n.settingsDailyReminderSubtitle),
              value: reminderOn,
              onChanged: (bool v) {
                unawaited(
                  ref
                      .read(dailyReminderEnabledProvider.notifier)
                      .setEnabled(v),
                );
              },
            ),
            _Divider(color: scheme.outlineVariant),
            _SectionTitle(text: l10n.settingsSectionAccount),
            _SettingsRow(
              key: const Key('settings_tile_customer_care'),
              label: l10n.customerCareSettingsRow,
              onTap: () async {
                final ProfileHubEntity hub =
                    await ref.read(profileHubProvider.future);
                if (!context.mounted) {
                  return;
                }
                await Navigator.of(context).push<void>(
                  MaterialPageRoute<void>(
                    builder: (_) => CustomerCareChatPage(
                      displayName: hub.user.displayName,
                    ),
                  ),
                );
              },
            ),
            _Divider(color: scheme.outlineVariant),
            _SettingsRow(
              key: const Key('settings_tile_language'),
              label: l10n.settingsRowLanguage,
              value: settingsLanguageDisplayLabel(l10n, overrideLocale),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const SettingsLanguagePage(),
                  ),
                );
              },
            ),
            _Divider(color: scheme.outlineVariant),
            if (signedInUser != null) ...<Widget>[
              _SettingsRow(
                key: const Key('settings_tile_log_out'),
                label: l10n.settingsRowLogout,
                value: signedInUser.email,
                onTap: () =>
                    _confirmLogoutFromSettings(context, ref, l10n),
              ),
              _Divider(color: scheme.outlineVariant),
            ],
            _SettingsRow(
              key: const Key('settings_tile_about'),
              label: l10n.settingsRowAbout(_kAppDisplayName),
              onTap: () => _comingSoon(
                context,
                l10n,
                l10n.settingsRowAbout(_kAppDisplayName),
              ),
            ),
            _Divider(color: scheme.outlineVariant),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                key: const Key('settings_delete_account'),
                onPressed: () => _confirmDeleteAccount(context, l10n),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFE57373),
                ),
                child: Text(
                  l10n.settingsDeleteAccountAction,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _kAppDisplayName,
                    textAlign: TextAlign.center,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.settingsVersionLabel(_kAppVersion, _kAppBuildDate),
                    textAlign: TextAlign.center,
                    style: textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
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

class _SettingsPageHeader extends StatelessWidget {
  const _SettingsPageHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 16, 8),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: AppColors.onSurface,
          ),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 24,
      endIndent: 24,
      color: color,
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    super.key,
    required this.label,
    required this.onTap,
    this.value,
  });

  final String label;
  final String? value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                label,
                style: textTheme.bodyLarge,
              ),
            ),
            if (value != null) ...<Widget>[
              Flexible(
                child: Text(
                  value!,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
            Icon(
              Icons.chevron_right_rounded,
              color: scheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
