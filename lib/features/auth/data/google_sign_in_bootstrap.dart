import 'dart:developer' as developer;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';

import 'google_sign_in_client_config.dart';

/// Initializes [GoogleSignIn]; call once after [Firebase.initializeApp].
///
/// **Firebase Console (manual):** enable Authentication → Google; add Android
/// SHA-1/256; re-download `google-services.json` (must include `oauth_client`
/// entries) and `GoogleService-Info.plist` (must include `REVERSED_CLIENT_ID`).
Future<void> initializeGoogleSignInPlugin() async {
  try {
    await GoogleSignIn.instance.initialize(
      clientId: googleSignInInitializeClientId(),
      serverClientId: googleSignInInitializeServerClientId(),
    );
  } on Object catch (error, stackTrace) {
    developer.log(
      'GoogleSignIn.initialize failed',
      error: error,
      stackTrace: stackTrace,
    );
    rethrow;
  }
  if (kIsWeb && kGoogleSignInWebClientId.isEmpty) {
    developer.log(
      'Web Google Sign-In: set GOOGLE_WEB_CLIENT_ID via --dart-define or '
      'add <meta name="google-signin-client_id" content="…"> to web/index.html.',
    );
  }
}
