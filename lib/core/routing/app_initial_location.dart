import 'package:shared_preferences/shared_preferences.dart';

import '../prefs/app_preferences_keys.dart';

/// First route after startup: onboarding, then welcome or shop.
String resolveInitialAppLocation({
  required SharedPreferences prefs,
  required bool sessionStarted,
  bool? onboardingCompletedOverride,
}) {
  final bool onboardingDone = onboardingCompletedOverride ??
      (prefs.getBool(AppPreferencesKeys.onboardingCompleted) ?? false);
  if (!onboardingDone) {
    return '/onboarding';
  }
  if (sessionStarted) {
    return '/shop';
  }
  return '/welcome';
}
