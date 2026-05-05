import 'dart:developer' as developer;

import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../create_account/presentation/pages/create_account_page.dart';
import 'welcome_login_dialog.dart';
import 'welcome_secondary_row.dart';

/// Primary and secondary actions for the welcome flow.
class WelcomeActions extends StatelessWidget {
  const WelcomeActions({
    super.key,
    required this.l10n,
    required this.onContinueToShop,
  });

  final AppLocalizations l10n;
  final VoidCallback onContinueToShop;

  static const double _ctaRadius = 14;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FilledButton(
          onPressed: () {
            developer.log('welcome_primary_cta');
            onContinueToShop();
          },
          style: FilledButton.styleFrom(
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_ctaRadius),
            ),
          ),
          child: Text(l10n.welcomePrimaryCta),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () {
            developer.log('welcome_create_account');
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const CreateAccountPage(),
              ),
            );
          },
          child: Text(l10n.loginCreateAccountLink),
        ),
        const SizedBox(height: 8),
        WelcomeSecondaryRow(
          l10n: l10n,
          theme: theme,
          onOpenLogin: () async {
            developer.log('welcome_secondary_cta');
            final bool? signedIn = await showWelcomeLoginDialog(context, l10n);
            if (signedIn == true && context.mounted) {
              onContinueToShop();
            }
          },
        ),
      ],
    );
  }
}
