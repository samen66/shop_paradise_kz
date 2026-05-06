import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// OAuth 2.0 **Web** client ID (`….apps.googleusercontent.com`), used for
/// [GoogleSignIn.initialize] on web and as `serverClientId` on mobile for
/// Firebase ID tokens.
///
/// Set at build time, for example:
/// `flutter run --dart-define=GOOGLE_WEB_CLIENT_ID=xxx.apps.googleusercontent.com`
///
/// Also add the same value to `web/index.html` as meta `google-signin-client_id`
/// (see [google_sign_in_web](https://pub.dev/packages/google_sign_in_web)).
const String kGoogleSignInWebClientId = String.fromEnvironment(
  'GOOGLE_WEB_CLIENT_ID',
  defaultValue: '',
);

/// iOS/macOS **client** ID (`CLIENT_ID` in `GoogleService-Info.plist`), if not
/// using the project default below.
const String kGoogleSignInIosClientId = String.fromEnvironment(
  'GOOGLE_IOS_CLIENT_ID',
  defaultValue: '',
);

/// Default **iOS** OAuth client for `shop-paradise-demo` (public; not secret).
/// Matches `GoogleService-Info.plist` → `CLIENT_ID`.
const String kDefaultFirebaseIosClientId =
    '1053821541115-7od7maod4ut638jj1um616uqus31pgmq.apps.googleusercontent.com';

/// Default **Web** OAuth client for Firebase Auth on mobile (public).
/// Matches `google-services.json` → `oauth_client` with `client_type: 3`.
const String kDefaultFirebaseWebServerClientId =
    '1053821541115-vukk44infd2usq3i84g8fkil9ekfp605.apps.googleusercontent.com';

bool get _isApplePlatform {
  if (kIsWeb) {
    return false;
  }
  return defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.macOS;
}

/// Passed to [GoogleSignIn.initialize] `clientId`.
String? googleSignInInitializeClientId() {
  if (kIsWeb) {
    return kGoogleSignInWebClientId.isEmpty ? null : kGoogleSignInWebClientId;
  }
  if (_isApplePlatform) {
    return kGoogleSignInIosClientId.isEmpty
        ? kDefaultFirebaseIosClientId
        : kGoogleSignInIosClientId;
  }
  return null;
}

/// Passed to [GoogleSignIn.initialize] `serverClientId` (non-web).
String? googleSignInInitializeServerClientId() {
  if (kIsWeb) {
    return null;
  }
  return kGoogleSignInWebClientId.isEmpty
      ? kDefaultFirebaseWebServerClientId
      : kGoogleSignInWebClientId;
}
