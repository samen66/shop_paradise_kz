import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../login/presentation/pages/login_page.dart';

/// Opens the full-screen login flow used by the welcome screen.
Future<void> showWelcomeLoginDialog(BuildContext context, AppLocalizations _) {
  return Navigator.of(context).push<void>(
    MaterialPageRoute<void>(
      builder: (BuildContext context) => const LoginPage(),
    ),
  );
}
