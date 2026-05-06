import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

/// Returns [AppLocalizations] when delegates are wired; null otherwise.
AppLocalizations? tryAppLocalizations(BuildContext context) {
  return AppLocalizations.of(context);
}

extension AppLocalizationsX on BuildContext {
  /// Localizations for this route; requires [MaterialApp] delegates.
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
