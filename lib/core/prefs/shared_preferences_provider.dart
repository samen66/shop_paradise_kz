import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Live app data uses an override from [main] after [SharedPreferences.getInstance].
///
/// Tests must [ProviderScope] override with a mock-backed instance.
final Provider<SharedPreferences> sharedPreferencesProvider =
    Provider<SharedPreferences>(
      (Ref ref) => throw UnimplementedError(
        'sharedPreferencesProvider: override in main() or tests.',
      ),
    );
