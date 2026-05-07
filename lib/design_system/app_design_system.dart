import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFF101010);
  static const lightBackground = Color(0xFFFFFFFF);
  static const lightSurface = Color(0xFFF5F5F5);
  static const lightSurfaceRaised = Color(0xFFFFFFFF);
  static const lightTextPrimary = Color(0xFF17181B);
  static const lightTextSecondary = Color(0xB317181B);
  static const lightTextTertiary = Color(0x7317181B);
  static const lightOutlineSubtle = Color(0x1F17181B);
  static const surface = Color(0xFF1C1C1E);
  static const surfaceRaised = Color(0xFF27272A);
  static const textPrimary = Color(0xFFF8F8F8);
  static const textSecondary = Color(0xCCFFFFFF);
  static const textTertiary = Color(0x80FFFFFF);
  static const outlineSubtle = Color(0x1FFFFFFF);
  static const buttonPrimary = Color(0xFFFFFFFF);
  static const buttonOnPrimary = Color(0xFF111111);
  static const progressActive = Color(0xFFFFFFFF);
  static const progressInactive = Color(0xFF3D3D40);
  static const accent = Color(0xFFFF1A1A);
}

extension AppThemeColors on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  Color get appBackground => Theme.of(this).scaffoldBackgroundColor;

  Color get appSurface => colorScheme.surface;

  Color get appSurfaceRaised => colorScheme.surfaceContainerHighest;

  Color get appTextPrimary => colorScheme.onSurface;

  Color get appTextSecondary => colorScheme.onSurface.withValues(alpha: 0.78);

  Color get appTextTertiary => colorScheme.onSurface.withValues(alpha: 0.48);

  Color get appOutlineSubtle => colorScheme.outlineVariant;

  Color get appButtonPrimary => colorScheme.primary;

  Color get appButtonOnPrimary => colorScheme.onPrimary;

  Color get appAccent => colorScheme.error;
}

class AppSpacing {
  static const double xs = 6;
  static const double sm = 10;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 36;
}

class AppRadius {
  static const double card = 16;
  static const double button = 16;
}

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
    fontSize: 32,
    color: AppColors.textPrimary,
  );

  static const TextStyle title = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
    fontSize: 36,
    color: AppColors.textPrimary,
    letterSpacing: -0.6,
    height: 1.15,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: AppColors.textPrimary,
    letterSpacing: -0.6,
    height: 1.15,
  );

  static const TextStyle bodyMuted = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: AppColors.textSecondary,
    letterSpacing: -0.42,
    height: 1.2,
  );

  static const TextStyle label = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: AppColors.textSecondary,
    letterSpacing: -0.36,
  );

  static const TextStyle value = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: AppColors.textPrimary,
    letterSpacing: -0.42,
  );

  static const TextStyle valueLarge = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: AppColors.textPrimary,
    letterSpacing: -0.48,
  );

  static const TextStyle otpDigit = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 24,
    color: AppColors.textPrimary,
    letterSpacing: -0.72,
  );

  static const TextStyle inlineAction = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: AppColors.textPrimary,
    letterSpacing: -0.42,
    height: 1.2,
  );

  static const TextStyle inlineActionSmall = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
    fontSize: 12,
    color: AppColors.textPrimary,
    letterSpacing: -0.36,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 10,
    color: AppColors.textSecondary,
    letterSpacing: -0.3,
    height: 1.2,
  );

  static const TextStyle button = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: AppColors.buttonOnPrimary,
    letterSpacing: -0.48,
  );
}

ThemeData buildAppTheme({required Brightness brightness}) {
  final bool isDark = brightness == Brightness.dark;
  final Color background = isDark
      ? AppColors.background
      : AppColors.lightBackground;
  final Color surface = isDark ? AppColors.surface : AppColors.lightSurface;
  final Color surfaceRaised = isDark
      ? AppColors.surfaceRaised
      : AppColors.lightSurfaceRaised;
  final Color textPrimary = isDark
      ? AppColors.textPrimary
      : AppColors.lightTextPrimary;
  final Color outlineSubtle = isDark
      ? AppColors.outlineSubtle
      : AppColors.lightOutlineSubtle;
  final Color primary = isDark
      ? AppColors.buttonPrimary
      : AppColors.lightTextPrimary;
  final Color onPrimary = isDark
      ? AppColors.buttonOnPrimary
      : AppColors.lightSurfaceRaised;

  return ThemeData(
    scaffoldBackgroundColor: background,
    fontFamily: 'Inter',
    useMaterial3: true,
    brightness: brightness,
    colorScheme:
        ColorScheme.fromSeed(
          seedColor: AppColors.accent,
          brightness: brightness,
        ).copyWith(
          primary: primary,
          onPrimary: onPrimary,
          surface: surface,
          surfaceContainerHighest: surfaceRaised,
          onSurface: textPrimary,
          outlineVariant: outlineSubtle,
          error: AppColors.accent,
          onError: Colors.white,
        ),
    iconTheme: IconThemeData(color: textPrimary),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: textPrimary,
      selectionColor: AppColors.accent.withValues(alpha: 0.28),
    ),
  );
}
