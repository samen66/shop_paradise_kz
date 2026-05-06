# Google sign-in, profile, and session

## Purpose

- **Profile hub** merges mock catalog data from `ProfileRepository` with the
  signed-in Firebase `User` (display name, email, photo URL) when available.
- **Settings → Your Profile** updates `FirebaseAuth` when a user is signed in;
  otherwise it keeps using the mock repository (widget tests).
- **Settings → Log out** ends Google + Firebase sessions and sets
  `sessionStartedProvider` to `false` so the app returns to `WelcomePage`.

## Key files

| Area | File |
|------|------|
| Session flag | `lib/core/session/session_started_provider.dart` |
| Root home switch | `lib/main.dart` |
| Auth stream (safe in tests) | `lib/features/auth/presentation/auth_providers.dart` |
| Profile overlay | `lib/features/profile/presentation/providers/profile_providers.dart` |
| Edit profile | `lib/features/profile/presentation/pages/settings_profile_page.dart` |
| Log out | `lib/features/profile/presentation/pages/settings_page.dart` |

## Tests

`authStateProvider` emits a single `null` when `Firebase.apps` is empty so
widget tests do not require `Firebase.initializeApp()`.
