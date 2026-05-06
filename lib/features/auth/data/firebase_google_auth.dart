import 'dart:developer' as developer;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Signs in to Firebase using a [GoogleSignInAccount] from
/// [GoogleSignIn.authenticate] or the web GIS button flow.
Future<UserCredential> signInToFirebaseWithGoogleAccount(
  GoogleSignInAccount account,
) async {
  final GoogleSignInAuthentication googleAuth = account.authentication;
  final String? idToken = googleAuth.idToken;
  if (idToken == null || idToken.isEmpty) {
    throw StateError('Google Sign-In did not return an id token.');
  }
  final OAuthCredential credential = GoogleAuthProvider.credential(
    idToken: idToken,
  );
  try {
    return await FirebaseAuth.instance.signInWithCredential(credential);
  } on FirebaseAuthException catch (error, stackTrace) {
    developer.log(
      'Firebase signInWithCredential failed',
      error: error,
      stackTrace: stackTrace,
    );
    rethrow;
  }
}

/// Interactive Google sign-in on platforms where
/// [GoogleSignIn.supportsAuthenticate] is true.
Future<UserCredential> signInWithGoogleInteractive() async {
  final GoogleSignInAccount account = await GoogleSignIn.instance.authenticate();
  return signInToFirebaseWithGoogleAccount(account);
}
