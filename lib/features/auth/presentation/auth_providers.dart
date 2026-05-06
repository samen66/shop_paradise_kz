import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Firebase Auth instance for the app.
final Provider<FirebaseAuth> firebaseAuthProvider =
    Provider<FirebaseAuth>((Ref ref) {
  return FirebaseAuth.instance;
});

/// Emits [User] when signed in and `null` when signed out.
///
/// When Firebase is not initialized (e.g. widget tests), emits `null` once.
final StreamProvider<User?> authStateProvider = StreamProvider<User?>((
  Ref ref,
) {
  if (Firebase.apps.isEmpty) {
    return Stream<User?>.value(null);
  }
  return ref.watch(firebaseAuthProvider).authStateChanges();
});
