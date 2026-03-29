import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Builds [ThemeData] for the app. Use [AppTheme.light] / [AppTheme.dark].
abstract final class AppTheme {
  static const double _pillRadius = 28;
  static const double _ctaMinHeight = 52;

  static ThemeData get light {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      error: AppColors.error,
      onError: AppColors.onError,
    ).copyWith(
      surfaceContainerHighest: AppColors.surfaceContainerHighest,
      outlineVariant: AppColors.outlineVariant,
      onSurfaceVariant: AppColors.onSurfaceVariant,
    );
    return _buildTheme(
      colorScheme: colorScheme,
      splashColor: AppColors.primary.withValues(alpha: 0.12),
      highlightColor: AppColors.primary.withValues(alpha: 0.08),
      hintColor: AppColors.hint,
    );
  }

  static ThemeData get dark {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkOnSurface,
      error: AppColors.error,
      onError: AppColors.onError,
    ).copyWith(
      surfaceContainerHighest: AppColors.darkSurfaceContainerHighest,
      outlineVariant: AppColors.darkOutlineVariant,
      onSurfaceVariant: AppColors.darkOnSurfaceVariant,
    );
    return _buildTheme(
      colorScheme: colorScheme,
      splashColor: AppColors.primary.withValues(alpha: 0.24),
      highlightColor: AppColors.primary.withValues(alpha: 0.16),
      hintColor: AppColors.darkHint,
    );
  }

  static ThemeData _buildTheme({
    required ColorScheme colorScheme,
    required Color splashColor,
    required Color highlightColor,
    required Color hintColor,
  }) {
    final ThemeData base = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      splashColor: splashColor,
      highlightColor: highlightColor,
    );

    final TextTheme textTheme = GoogleFonts.interTextTheme(base.textTheme).copyWith(
      headlineLarge: GoogleFonts.inter(
        fontWeight: FontWeight.w700,
        color: colorScheme.onSurface,
      ).merge(base.textTheme.headlineLarge),
      headlineMedium: GoogleFonts.inter(
        fontWeight: FontWeight.w700,
        color: colorScheme.onSurface,
      ).merge(base.textTheme.headlineMedium),
      titleLarge: GoogleFonts.inter(
        fontWeight: FontWeight.w700,
        color: colorScheme.onSurface,
      ).merge(base.textTheme.titleLarge),
      bodyMedium: GoogleFonts.inter(
        color: colorScheme.onSurfaceVariant,
      ).merge(base.textTheme.bodyMedium),
      bodySmall: GoogleFonts.inter(
        color: colorScheme.onSurfaceVariant,
      ).merge(base.textTheme.bodySmall),
    );

    final ButtonStyle primaryButtonStyle = FilledButton.styleFrom(
      minimumSize: const Size(double.infinity, _ctaMinHeight),
      foregroundColor: AppColors.onPrimary,
      backgroundColor: AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_pillRadius),
      ),
      textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
    );

    final OutlineInputBorder pillBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(_pillRadius),
      borderSide: BorderSide.none,
    );

    return base.copyWith(
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: textTheme.titleLarge,
      ),
      filledButtonTheme: FilledButtonThemeData(style: primaryButtonStyle),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, _ctaMinHeight),
          foregroundColor: AppColors.onPrimary,
          backgroundColor: AppColors.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_pillRadius),
          ),
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        hintStyle: GoogleFonts.inter(color: hintColor),
        labelStyle: GoogleFonts.inter(color: colorScheme.onSurfaceVariant),
        border: pillBorder,
        enabledBorder: pillBorder,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_pillRadius),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_pillRadius),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_pillRadius),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),
    );
  }
}
