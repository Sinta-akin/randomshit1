import 'package:flutter/material.dart';

/// AutoMate design system extracted from the Figma project.
/// All colors, typography, spacing, and dimensions are defined centrally.
abstract class AppTheme {
  // MARK: - Colors

  /// Deep dark background used on most screens.
  static const Color scaffoldBackground = Color(0xFF121212);

  /// Slightly lighter surface for cards and containers.
  static const Color surface = Color(0xFF1E1E1E);

  /// Primary brand blue (buttons, active states).
  static const Color primaryBlue = Color(0xFF2B5DFF);

  /// Brand accent orange (used in AutoMate logo).
  static const Color accentOrange = Color(0xFFFF6B00);

  /// Secondary text color.
  static const Color textSecondary = Color(0xFF94A3B8);

  /// Primary text color (near white).
  static const Color textPrimary = Color(0xFFFFFFFF);

  /// Divider/border color.
  static const Color border = Color(0xFF333333);

  /// Success green (checkmarks).
  static const Color successGreen = Color(0xFF10B981);

  /// Error red.
  static const Color errorRed = Color(0xFFEF4444);

  /// Button blue gradient start.
  static const Color buttonGradientStart = Color(0xFF3B82F6);

  /// Button blue gradient end.
  static const Color buttonGradientEnd = Color(0xFF2563EB);

  // MARK: - Typography

  static const String fontFamily = 'Inter';

  static const TextStyle headline1 = TextStyle(
    fontFamily: 'Inter',
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: textPrimary,
    height: 1.2,
  );

  static const TextStyle headline2 = TextStyle(
    fontFamily: 'Inter',
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: textPrimary,
    height: 1.3,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: textSecondary,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: textSecondary,
    height: 1.5,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: 'Inter',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: textSecondary,
  );

  static const TextStyle buttonText = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  static const TextStyle sectionHeading = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: textPrimary,
  );

  static const TextStyle sectionSubtitle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: accentOrange,
  );

  // MARK: - Spacing

  static const double spacingXs = 4;
  static const double spacingSm = 8;
  static const double spacingMd = 16;
  static const double spacingLg = 24;
  static const double spacingXl = 32;
  static const double spacingXxl = 48;

  // MARK: - Border Radius

  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 24;
  static const double radiusFull = 30;

  // MARK: - ThemeData

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: scaffoldBackground,
      colorScheme: const ColorScheme.dark(
        primary: primaryBlue,
        surface: surface,
        onPrimary: textPrimary,
        onSurface: textPrimary,
      ),
      fontFamily: fontFamily,
      textTheme: const TextTheme(
        headlineLarge: headline1,
        headlineMedium: headline2,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
        labelMedium: labelMedium,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: textPrimary,
          elevation: 0,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusXl),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(color: primaryBlue, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        hintStyle: const TextStyle(
          color: textSecondary,
          fontSize: 16,
        ),
      ),
    );
  }
}
