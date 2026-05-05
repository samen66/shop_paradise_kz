import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/currency/app_currency_provider.dart';
import '../../../../core/session/session_started_provider.dart';
import '../../../../core/l10n/l10n_helpers.dart';
import '../../../../core/locale/app_locale_override_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../customer_care_chat/presentation/pages/customer_care_chat_page.dart';
import '../../domain/entities/profile_entities.dart';
import 'settings_currency_page.dart';
import 'settings_language_page.dart';
import 'settings_payment_methods_page.dart';
import 'settings_profile_page.dart';
import 'settings_shipping_address_page.dart';
import '../../../auth/presentation/auth_providers.dart';
import '../providers/profile_providers.dart';

/// Confirms sign-out, clears Google + Firebase sessions, returns to Welcome.
Future<void> _confirmLogoutFromSettings(
  BuildContext context,
  WidgetRef ref,
) async {
  final bool? ok = await showDialog<bool>(
    context: context,
    builder: (BuildContext ctx) => AlertDialog(
      title: const Text('Log out'),
      content: const Text('Log out of your account?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(true),
          child: const Text('Log out'),
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

  static const String _appDisplayName = 'Shop Paradise';
  static const String _versionLabel = 'Version 1.0.0 · April, 2026';

  void _comingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$feature — coming soon')),
    );
  }

  Future<void> _confirmDeleteAccount(BuildContext context) async {
    final bool? ok = await showDialog<bool>(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        title: const Text('Delete account?'),
        content: const Text(
          'You will not be able to restore your data. This is a demo only.',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account deletion is not available in demo')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations? l10n = tryAppLocalizations(context);
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final Locale effectiveLocale =
        ref.watch(appLocaleOverrideProvider) ?? Localizations.localeOf(context);
    final String currencyCode = ref.watch(appCurrencyCodeProvider);
    final User? signedInUser = ref.watch(authStateProvider).valueOrNull;

    return Scaffold(
      key: const Key('settings_page'),
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 32),
          children: <Widget>[
            const _SettingsPageHeader(),
            const SizedBox(height: 8),
            _SectionTitle(text: 'Personal'),
            _SettingsRow(
              key: const Key('settings_tile_profile'),
              label: 'Profile',
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
              label: 'Shipping Address',
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
              label: 'Payment methods',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const SettingsPaymentMethodsPage(),
                  ),
                );
              },
            ),
            _Divider(color: scheme.outlineVariant),
            _SectionTitle(text: 'Shop'),
            _SettingsRow(
              key: const Key('settings_tile_shopping_notes'),
              label: 'Shopping notes (offline)',
              onTap: () => context.push('/notes'),
            ),
            _Divider(color: scheme.outlineVariant),
            _SettingsRow(
              key: const Key('settings_tile_spending_chart'),
              label: 'Spending chart',
              onTap: () => context.push('/analytics'),
            ),
            _Divider(color: scheme.outlineVariant),
            _SettingsRow(
              key: const Key('settings_tile_country'),
              label: 'Country',
              value: 'Vietnam',
              onTap: () => _comingSoon(context, 'Country'),
            ),
            _Divider(color: scheme.outlineVariant),
            _SettingsRow(
              key: const Key('settings_tile_currency'),
              label: 'Currency',
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
              label: 'Sizes',
              value: 'UK',
              onTap: () => _comingSoon(context, 'Sizes'),
            ),
            _Divider(color: scheme.outlineVariant),
            _SettingsRow(
              key: const Key('settings_tile_terms'),
              label: 'Terms and Conditions',
              onTap: () => _comingSoon(context, 'Terms and Conditions'),
            ),
            _Divider(color: scheme.outlineVariant),
            _SectionTitle(text: 'Account'),
            if (l10n != null)
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
            if (l10n != null) _Divider(color: scheme.outlineVariant),
            _SettingsRow(
              key: const Key('settings_tile_language'),
              label: 'Language',
              value: settingsLanguageDisplayLabel(effectiveLocale),
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
                label: 'Log out',
                value: signedInUser.email,
                onTap: () => _confirmLogoutFromSettings(context, ref),
              ),
              _Divider(color: scheme.outlineVariant),
            ],
            _SettingsRow(
              key: const Key('settings_tile_about'),
              label: 'About $_appDisplayName',
              onTap: () => _comingSoon(context, 'About'),
            ),
            _Divider(color: scheme.outlineVariant),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                key: const Key('settings_delete_account'),
                onPressed: () => _confirmDeleteAccount(context),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFE57373),
                ),
                child: const Text(
                  'Delete My Account',
                  style: TextStyle(fontWeight: FontWeight.w600),
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
                    _appDisplayName,
                    textAlign: TextAlign.center,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _versionLabel,
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
  const _SettingsPageHeader();

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
              'Settings',
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
