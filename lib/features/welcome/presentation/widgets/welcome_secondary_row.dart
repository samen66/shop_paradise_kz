import 'dart:developer' as developer;

import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// Secondary CTA: account hint text and circular arrow button.
class WelcomeSecondaryRow extends StatelessWidget {
  const WelcomeSecondaryRow({
    super.key,
    required this.l10n,
    required this.theme,
  });

  final AppLocalizations l10n;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = theme.colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Text(
            l10n.welcomeSecondaryCta,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Material(
          color: scheme.primary,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () {
              developer.log('welcome_secondary_cta');
            },
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Icon(
                Icons.arrow_forward,
                color: scheme.onPrimary,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
