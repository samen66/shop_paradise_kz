import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// Modal sign-in form placeholder (dismiss with Close).
Future<void> showWelcomeLoginDialog(
  BuildContext context,
  AppLocalizations l10n,
) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext dialogContext) {
      return GestureDetector(
        onTap: () => FocusScope.of(dialogContext).unfocus(),
        behavior: HitTestBehavior.deferToChild,
        child: AlertDialog(
          key: const Key('welcome_login_dialog'),
          title: Text(l10n.loginTitle),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: l10n.loginEmailLabel,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autocorrect: false,
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    labelText: l10n.loginPasswordLabel,
                  ),
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(l10n.loginCloseAction),
            ),
          ],
        ),
      );
    },
  );
}
