import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

/// Returns [AppLocalizations] when delegates are wired; null otherwise.
AppLocalizations? tryAppLocalizations(BuildContext context) {
  return AppLocalizations.of(context);
}
