import 'package:flutter/material.dart';

/// Brand and semantic colors for light and dark themes.
abstract final class AppColors {
  static const Color primary = Color(0xFF0055FF);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF000000);
  static const Color onSurfaceVariant = Color(0xFF424242);
  static const Color surfaceContainerHighest = Color(0xFFF5F5F5);
  static const Color outlineVariant = Color(0xFFE0E0E0);
  static const Color blobLightBlue = Color(0xFFE8EEFF);
  static const Color hint = Color(0xFFBDBDBD);
  static const Color error = Color(0xFFB3261E);
  static const Color onError = Color(0xFFFFFFFF);

  static const Color darkSurface = Color(0xFF121212);
  static const Color darkOnSurface = Color(0xFFE8E8E8);
  static const Color darkOnSurfaceVariant = Color(0xFFCACACA);
  static const Color darkSurfaceContainerHighest = Color(0xFF2C2C2E);
  static const Color darkOutlineVariant = Color(0xFF424242);
  static const Color darkHint = Color(0xFF888888);
}
