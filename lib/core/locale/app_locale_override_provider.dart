import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// When non-null, [MaterialApp] uses this locale instead of device resolution.
final appLocaleOverrideProvider = StateProvider<Locale?>((Ref ref) => null);
