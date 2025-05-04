import 'package:flutter/material.dart';
import 'constants.dart';

class AppTheme {
  // Private Constructor
  AppTheme._();

  // Colors - Dark Mode (Default) - Extracted from reference CSS
  static const Color darkBackground = Color(
    0xFF18181B,
  ); // #18181B - Updated as per requirement
  static const Color darkSurface = Color(
    0xFF29242F,
  ); // --arc-palette-foregroundTertiary
  static const Color darkBorder = Color(
    0xFF524E57,
  ); // --arc-palette-focus without opacity
  static const Color darkTextPrimary = Color(
    0xFFF0EEF2,
  ); // --arc-palette-foregroundPrimary
  static const Color darkTextSecondary = Color(
    0xFF9D91AC,
  ); // --arc-palette-foregroundSecondary
  static const Color darkTextMuted = Color(
    0xFFa1a1aa,
  ); // --arc-palette-subtitle

  // Colors - Light Mode
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Color(0xFFF5F5F5);
  static const Color lightBorder = Color(
    0xFFE5E5E5,
  ); // Border color from reference
  static const Color lightTextPrimary = Color(
    0xFF18181B,
  ); // Dark text from reference
  static const Color lightTextSecondary = Color(
    0xFF3F3F46,
  ); // Secondary text from reference
  static const Color lightTextMuted = Color(
    0xFF71717A,
  ); // Muted text from reference

  // Typography - Matches reference
  static const String fontFamily = 'HankenGrotesk';
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  // Line heights - Matches reference CSS
  static const double lineHeightNormal = 1.15; // line-height: 1.15 from CSS
  static const double lineHeightTight = 1.0;
  static const double lineHeightLoose = 1.5;

  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: lightTextPrimary,
        onPrimary: lightBackground,
        secondary: lightTextSecondary,
        onSecondary: lightBackground,
        surface: lightSurface,
        onSurface: lightTextPrimary,
      ),
      scaffoldBackgroundColor: lightBackground,
      cardColor: lightSurface,
      dividerColor: lightBorder,
      dividerTheme: const DividerThemeData(
        color: lightBorder,
        thickness: 1,
        space: 24,
      ),
      textTheme: _buildTextTheme(false),
      iconTheme: const IconThemeData(color: lightTextPrimary, size: 20),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: lightTextPrimary),
        titleTextStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 16,
          fontWeight: bold,
          color: lightTextPrimary,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: lightTextPrimary,
          textStyle: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 14,
            fontWeight: medium,
          ),
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
        ),
      ),
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: darkTextPrimary,
        onPrimary: darkBackground,
        secondary: darkTextMuted,
        onSecondary: darkBackground,
        surface: darkSurface,
        onSurface: darkTextPrimary,
      ),
      scaffoldBackgroundColor: darkBackground,
      cardColor: darkSurface,
      dividerColor: darkBorder,
      dividerTheme: const DividerThemeData(
        color: darkBorder,
        thickness: 1,
        space: 24,
      ),
      textTheme: _buildTextTheme(true),
      iconTheme: const IconThemeData(color: darkTextPrimary, size: 20),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: darkTextPrimary),
        titleTextStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 16,
          fontWeight: bold,
          color: darkTextPrimary,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: darkTextPrimary,
          textStyle: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 14,
            fontWeight: medium,
          ),
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
        ),
      ),
    );
  }

  static TextTheme _buildTextTheme(bool isDark) {
    final Color textPrimary = isDark ? darkTextPrimary : lightTextPrimary;
    final Color textSecondary = isDark ? darkTextMuted : lightTextSecondary;
    final Color textMuted = isDark ? darkTextMuted : lightTextMuted;

    return TextTheme(
      // h1 in CSS
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: AppTypography.font40,
        fontWeight: bold,
        letterSpacing: AppTypography.letterSpacing021,
        color: textPrimary,
        height: AppTypography.lineHeight35 / AppTypography.font40,
      ),
      // h2 in CSS
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: AppTypography.font32,
        fontWeight: bold,
        letterSpacing: AppTypography.letterSpacing021,
        color: textPrimary,
        height: AppTypography.lineHeight25 / AppTypography.font32,
      ),
      // h3 in CSS
      displaySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: AppTypography.font28,
        fontWeight: bold,
        letterSpacing: AppTypography.letterSpacing021,
        color: textPrimary,
        height: AppTypography.lineHeight225 / AppTypography.font28,
      ),
      // h4 in CSS
      headlineLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: AppTypography.font24,
        fontWeight: bold,
        letterSpacing: AppTypography.letterSpacing019,
        color: textPrimary,
        height: AppTypography.lineHeight20 / AppTypography.font24,
      ),
      // h5 in CSS
      headlineMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: AppTypography.font20,
        fontWeight: bold,
        letterSpacing: AppTypography.letterSpacing017,
        color: textPrimary,
        height: AppTypography.lineHeight20 / AppTypography.font20,
      ),
      // h6 in CSS
      headlineSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: AppTypography.font18,
        fontWeight: semiBold,
        letterSpacing: AppTypography.letterSpacing014,
        color: textPrimary,
        height: AppTypography.lineHeight15 / AppTypography.font18,
      ),
      // Font-18 in CSS
      titleLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: AppTypography.font18,
        fontWeight: medium,
        letterSpacing: AppTypography.letterSpacing014,
        color: textPrimary,
        height: AppTypography.lineHeight15 / AppTypography.font18,
      ),
      // Font-16 in CSS
      titleMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: AppTypography.font16,
        fontWeight: medium,
        letterSpacing: AppTypography.letterSpacing011,
        color: textPrimary,
        height: AppTypography.lineHeight15 / AppTypography.font16,
      ),
      // Font-16 body in CSS
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: AppTypography.font16,
        height: AppTypography.lineHeight15 / AppTypography.font16,
        fontWeight: regular,
        letterSpacing: AppTypography.letterSpacing011,
        color: textSecondary,
      ),
      // Font-14 in CSS
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: AppTypography.font14,
        height: AppTypography.lineHeight15 / AppTypography.font14,
        fontWeight: regular,
        letterSpacing: AppTypography.letterSpacing006,
        color: textSecondary,
      ),
      // Font-12 in CSS
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: AppTypography.font12,
        height: AppTypography.lineHeight10 / AppTypography.font12,
        fontWeight: regular,
        letterSpacing: AppTypography.letterSpacingNormal,
        color: textSecondary,
      ),
      // Font-10 in CSS
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: AppTypography.font10,
        fontWeight: medium,
        color: textMuted,
        height: AppTypography.lineHeight10 / AppTypography.font10,
        letterSpacing: AppTypography.letterSpacing01,
      ),
    );
  }

  // Helper methods to access colors directly
  static Color backgroundColor(bool isDark) =>
      isDark ? darkBackground : lightBackground;
  static Color surfaceColor(bool isDark) => isDark ? darkSurface : lightSurface;
  static Color textPrimaryColor(bool isDark) =>
      isDark ? darkTextPrimary : lightTextPrimary;
  static Color textSecondaryColor(bool isDark) =>
      isDark ? darkTextMuted : lightTextSecondary;
  static Color textMutedColor(bool isDark) =>
      isDark ? darkTextMuted : lightTextMuted;
  static Color borderColor(bool isDark) => isDark ? darkBorder : lightBorder;
}
