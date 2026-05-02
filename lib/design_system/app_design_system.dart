import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFF101010);
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

ThemeData buildAppTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: 'Inter',
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.buttonPrimary,
      onPrimary: AppColors.buttonOnPrimary,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
    ),
  );
}
