import 'package:flutter/material.dart';

import 'app_motion.dart';

class AppTheme {
  static const Color _primary = Color(0xFF1A47B8);
  static const Color _primaryLight = Color(0xFFD0E0FF);
  static const Color _danger = Color(0xFFF56565);
  static const Color _warning = Color(0xFFF6AD55);

  static const Color _backgroundLight = Color(0xFFFFFFFF);
  static const Color _surfaceLight = Color(0xFFF7FAFC);
  static const Color _surfaceVariantLight = Color(0xFFD0E0FF);

  static const Color _backgroundDark = Color(0xFF0F172A);
  static const Color _surfaceDark = Color(0xFF162033);
  static const Color _surfaceVariantDark = Color(0xFF21304A);

  static const Color _textPrimaryLight = Color(0xFF2D3748);
  static const Color _textSecondaryLight = Color(0xFF718096);

  static const Color _textPrimaryDark = Color(0xFFF7FAFC);
  static const Color _textSecondaryDark = Color(0xFFB6C2D2);

  static ThemeData lightTheme({bool comfortMode = false}) {
    final bodyLargeSize = comfortMode ? 18.0 : 16.0;
    final bodyMediumSize = comfortMode ? 16.0 : 14.0;
    final titleLargeSize = comfortMode ? 22.0 : 20.0;
    final titleMediumSize = comfortMode ? 18.0 : 16.0;
    final titleSmallSize = comfortMode ? 16.0 : 14.0;
    final borderRadius = comfortMode ? 20.0 : 18.0;
    final scheme = const ColorScheme.light(
      primary: _primary,
      secondary: _primaryLight,
      tertiary: _warning,
      error: _danger,
      surface: _surfaceLight,
      onPrimary: Colors.white,
      onSecondary: _primary,
      onTertiary: Colors.white,
      onError: Colors.white,
      onSurface: _textPrimaryLight,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: scheme,
      primaryColor: _primary,
      scaffoldBackgroundColor: _backgroundLight,
      textTheme: TextTheme(
        displayLarge: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.8,
          color: _textPrimaryLight,
        ),
        headlineSmall: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
          color: _textPrimaryLight,
        ),
        titleLarge: TextStyle(
          fontSize: titleLargeSize,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.3,
          color: _textPrimaryLight,
        ),
        titleMedium: TextStyle(
          fontSize: titleMediumSize,
          fontWeight: FontWeight.w700,
          color: _textPrimaryLight,
        ),
        titleSmall: TextStyle(
          fontSize: titleSmallSize,
          fontWeight: FontWeight.w700,
          color: _textPrimaryLight,
        ),
        bodyLarge: TextStyle(
          fontSize: bodyLargeSize,
          fontWeight: FontWeight.w500,
          height: 1.42,
          color: _textSecondaryLight,
        ),
        bodyMedium: TextStyle(
          fontSize: bodyMediumSize,
          fontWeight: FontWeight.w500,
          height: 1.45,
          color: _textSecondaryLight,
        ),
        labelLarge: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        labelSmall: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: _textSecondaryLight,
        ),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: _backgroundLight,
        foregroundColor: _textPrimaryLight,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: _surfaceLight,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(comfortMode ? 24 : 22),
          side: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
      ),
      elevatedButtonTheme: _elevatedButtonTheme(
        background: _primary,
        foreground: Colors.white,
        comfortMode: comfortMode,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _surfaceVariantLight,
        hintStyle: const TextStyle(color: _textSecondaryLight),
        labelStyle: const TextStyle(color: _textSecondaryLight),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: _primary, width: 1.4),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
      ),
      dividerColor: const Color(0xFFE2E8F0),
      navigationBarTheme: NavigationBarThemeData(
        height: comfortMode ? 76 : 64,
        elevation: 0,
        backgroundColor: _backgroundLight,
        indicatorColor: _primaryLight,
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: comfortMode ? 14 : 12,
            fontWeight: FontWeight.w700,
            color: _textPrimaryLight,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: Size.fromHeight(comfortMode ? 56 : 52),
          side: const BorderSide(color: _primary, width: 1.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(comfortMode ? 18 : 16),
          ),
          textStyle: TextStyle(
            fontSize: comfortMode ? 16 : 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: _backgroundLight,
        selectedItemColor: _primary,
        unselectedItemColor: _textSecondaryLight,
        elevation: 0,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: _surfaceLight,
        selectedColor: _primaryLight,
        disabledColor: _surfaceLight,
        side: const BorderSide(color: Color(0xFFE2E8F0)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        labelStyle: const TextStyle(
          color: _textPrimaryLight,
          fontWeight: FontWeight.w600,
        ),
        secondaryLabelStyle: const TextStyle(
          color: _primary,
          fontWeight: FontWeight.w700,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: _textPrimaryLight,
        contentTextStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      pageTransitionsTheme: AppMotion.pageTransitionsTheme,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
    );
  }

  static ThemeData darkTheme({bool comfortMode = false}) {
    final bodyLargeSize = comfortMode ? 18.0 : 16.0;
    final bodyMediumSize = comfortMode ? 16.0 : 14.0;
    final titleLargeSize = comfortMode ? 22.0 : 20.0;
    final titleMediumSize = comfortMode ? 18.0 : 16.0;
    final titleSmallSize = comfortMode ? 16.0 : 14.0;
    final borderRadius = comfortMode ? 20.0 : 18.0;
    final scheme = const ColorScheme.dark(
      primary: _primary,
      secondary: _primaryLight,
      tertiary: _warning,
      error: _danger,
      surface: _surfaceDark,
      onPrimary: Colors.white,
      onSecondary: _primary,
      onTertiary: Colors.white,
      onError: Colors.white,
      onSurface: _textPrimaryDark,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      primaryColor: _primary,
      scaffoldBackgroundColor: _backgroundDark,
      textTheme: TextTheme(
        displayLarge: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.8,
          color: _textPrimaryDark,
        ),
        headlineSmall: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
          color: _textPrimaryDark,
        ),
        titleLarge: TextStyle(
          fontSize: titleLargeSize,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.3,
          color: _textPrimaryDark,
        ),
        titleMedium: TextStyle(
          fontSize: titleMediumSize,
          fontWeight: FontWeight.w700,
          color: _textPrimaryDark,
        ),
        titleSmall: TextStyle(
          fontSize: titleSmallSize,
          fontWeight: FontWeight.w700,
          color: _textPrimaryDark,
        ),
        bodyLarge: TextStyle(
          fontSize: bodyLargeSize,
          fontWeight: FontWeight.w500,
          height: 1.42,
          color: _textSecondaryDark,
        ),
        bodyMedium: TextStyle(
          fontSize: bodyMediumSize,
          fontWeight: FontWeight.w500,
          height: 1.45,
          color: _textSecondaryDark,
        ),
        labelLarge: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        labelSmall: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: _textSecondaryDark,
        ),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: _backgroundDark,
        foregroundColor: _textPrimaryDark,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: _surfaceDark,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(comfortMode ? 24 : 22),
          side: const BorderSide(color: Color(0xFF25334C)),
        ),
      ),
      elevatedButtonTheme: _elevatedButtonTheme(
        background: _primary,
        foreground: Colors.white,
        comfortMode: comfortMode,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _surfaceVariantDark,
        hintStyle: const TextStyle(color: _textSecondaryDark),
        labelStyle: const TextStyle(color: _textSecondaryDark),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: Color(0xFF2A3A56)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: _primary, width: 1.4),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: Color(0xFF2A3A56)),
        ),
      ),
      dividerColor: const Color(0xFF2A3A56),
      navigationBarTheme: NavigationBarThemeData(
        height: comfortMode ? 76 : 64,
        elevation: 0,
        backgroundColor: _backgroundDark,
        indicatorColor: _primary.withValues(alpha: 0.22),
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: comfortMode ? 14 : 12,
            fontWeight: FontWeight.w700,
            color: _textPrimaryDark,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: Size.fromHeight(comfortMode ? 56 : 52),
          side: const BorderSide(color: _primary, width: 1.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(comfortMode ? 18 : 16),
          ),
          textStyle: TextStyle(
            fontSize: comfortMode ? 16 : 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: _backgroundDark,
        selectedItemColor: _primary,
        unselectedItemColor: _textSecondaryDark,
        elevation: 0,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: _surfaceDark,
        selectedColor: _primary.withValues(alpha: 0.18),
        disabledColor: _surfaceDark,
        side: const BorderSide(color: Color(0xFF2A3A56)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        labelStyle: const TextStyle(
          color: _textPrimaryDark,
          fontWeight: FontWeight.w600,
        ),
        secondaryLabelStyle: const TextStyle(
          color: _textPrimaryDark,
          fontWeight: FontWeight.w700,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: _surfaceVariantDark,
        contentTextStyle: const TextStyle(color: _textPrimaryDark),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      pageTransitionsTheme: AppMotion.pageTransitionsTheme,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
    );
  }

  static ElevatedButtonThemeData _elevatedButtonTheme({
    required Color background,
    required Color foreground,
    bool comfortMode = false,
  }) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: background,
        foregroundColor: foreground,
        minimumSize: Size.fromHeight(comfortMode ? 60 : 56),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        textStyle: TextStyle(
          fontSize: comfortMode ? 16 : 15,
          fontWeight: FontWeight.w700,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(comfortMode ? 22 : 20),
        ),
      ),
    );
  }
}
