import 'package:flutter/material.dart';

import '../../../core/l10n/l10n_helpers.dart';
import '../../../l10n/app_localizations.dart';
import 'widgets/welcome_actions.dart';
import 'widgets/welcome_hero_section.dart';

/// Welcome (no bottom bar). [onContinueToShop] is used by the primary CTA
/// (e.g. browse catalog → main shell).
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key, required this.onContinueToShop});

  final VoidCallback onContinueToShop;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppLocalizations? l10n = tryAppLocalizations(context);
    final ColorScheme scheme = theme.colorScheme;
    if (l10n == null) {
      return Scaffold(
        backgroundColor: scheme.surface,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: SelectableText.rich(
                TextSpan(
                  text:
                      'AppLocalizations are missing. Add '
                      'AppLocalizations.delegate to MaterialApp.',
                  style: TextStyle(color: scheme.error),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(child: WelcomeHeroSection(l10n: l10n)),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: WelcomeActions(
                l10n: l10n,
                onContinueToShop: onContinueToShop,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
