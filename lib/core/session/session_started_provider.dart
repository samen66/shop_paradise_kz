import 'package:flutter_riverpod/flutter_riverpod.dart';

/// True when the user is in the main app shell (not [WelcomePage]).
///
/// [ShopParadiseApp] sets this from `kIsWeb` and [ShopParadiseApp.initialSessionStarted].
final StateProvider<bool> sessionStartedProvider =
    StateProvider<bool>((Ref ref) => false);
