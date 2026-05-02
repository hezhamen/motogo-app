import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFFFFFFFF);
  static const textPrimary = Color(0xFF111111);
  static const textSecondary = Color(0x99000000);
  static const surfaceField = Color(0xFFF5F5F5);
  static const buttonPrimary = Color(0xFF000000);
  static const buttonOnPrimary = Color(0xFFFFFFFF);
  static const progressActive = Color(0xFF111111);
  static const progressInactive = Color(0xFFCACACA);
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
    colorScheme: const ColorScheme.light(
      primary: AppColors.buttonPrimary,
      onPrimary: AppColors.buttonOnPrimary,
      surface: AppColors.background,
      onSurface: AppColors.textPrimary,
    ),
  );
}
