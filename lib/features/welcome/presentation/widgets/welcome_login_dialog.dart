import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../login/presentation/pages/login_page.dart';

/// Opens the full-screen login flow used by the welcome screen.
///
/// Returns `true` when sign-in completed successfully (e.g. Google).
Future<bool?> showWelcomeLoginDialog(
  BuildContext context,
  AppLocalizations _,
) {
  return Navigator.of(context).push<bool>(
    MaterialPageRoute<bool>(
      builder: (BuildContext context) => const LoginPage(),
    ),
  );
}
