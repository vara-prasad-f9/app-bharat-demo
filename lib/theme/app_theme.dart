// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFFD32F2F); // Premium Red to match logo
  static const Color secondary = Color(0xFF6B7280); // Slick Grey

  // Light Theme Colors
  static const Color lightBackground = Color(0xFFFFEDF7);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightError = Color(0xFFEF4444);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightOnSecondary = Color(0xFFFFFFFF);
  static const Color lightOnBackground = Color(0xFF111827);
  static const Color lightOnSurface = Color(0xFF111827);
  static const Color lightOnError = Color(0xFFFFFFFF);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF111827);
  static const Color darkSurface = Color(0xFF1F2937);
  static const Color darkError = Color(0xFFF87171);
  static const Color darkOnPrimary = Color(0xFFFFFFFF);
  static const Color darkOnSecondary = Color(0xFFFFFFFF);
  static const Color darkOnBackground = Color(0xFFF9FAFB);
  static const Color darkOnSurface = Color(0xFFF9FAFB);
  static const Color darkOnError = Color(0xFFFFFFFF);
}

class AppTextStyles {
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
    color: Color(0xFF111827),
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2,
    color: Color(0xFF111827),
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    color: Color(0xFF111827),
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    color: Color(0xFF374151),
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    color: Color(0xFF4B5563),
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.lightOnPrimary,
        secondary: AppColors.secondary,
        onSecondary: AppColors.lightOnSecondary,
        error: AppColors.lightError,
        onError: AppColors.lightOnError,
        background: AppColors.lightBackground,
        onBackground: AppColors.lightOnBackground,
        surface: AppColors.lightSurface,
        onSurface: AppColors.lightOnSurface,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.lightOnBackground,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.lightOnBackground,
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: AppTextStyles.headlineLarge,
        headlineMedium: AppTextStyles.headlineMedium,
        titleLarge: AppTextStyles.titleLarge,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        labelLarge: AppTextStyles.labelLarge,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.primary,
        onPrimary: AppColors.darkOnPrimary,
        secondary: AppColors.secondary,
        onSecondary: AppColors.darkOnSecondary,
        error: AppColors.darkError,
        onError: AppColors.darkOnError,
        background: AppColors.darkBackground,
        onBackground: AppColors.darkOnBackground,
        surface: AppColors.darkSurface,
        onSurface: AppColors.darkOnSurface,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.darkOnBackground,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.darkOnBackground,
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: AppTextStyles.headlineLarge.copyWith(
          color: AppColors.darkOnBackground,
        ),
        headlineMedium: AppTextStyles.headlineMedium.copyWith(
          color: AppColors.darkOnBackground,
        ),
        titleLarge: AppTextStyles.titleLarge.copyWith(
          color: AppColors.darkOnBackground,
        ),
        bodyLarge: AppTextStyles.bodyLarge.copyWith(
          color: AppColors.darkOnBackground,
        ),
        bodyMedium: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.darkOnSurface,
        ),
        labelLarge: AppTextStyles.labelLarge.copyWith(
          color: AppColors.darkOnSurface,
        ),
      ),
    );
  }
}
