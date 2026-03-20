import 'package:flutter/material.dart';

class AppTheme {
  // Soft Health Green
  static const Color _primary = Color(0xFF0F9D58);
  static const Color _secondary = Color(0xFF2563EB);
  static const Color _warning = Color(0xFFF59E0B);

  static const Color _backgroundLight = Color(0xFFF7FBF9);
  static const Color _surfaceLight = Color(0xFFFFFFFF);
  static const Color _surfaceVariantLight = Color(0xFFECFDF3);

  static const Color _backgroundDark = Color(0xFF07130D);
  static const Color _surfaceDark = Color(0xFF0F1F17);
  static const Color _surfaceVariantDark = Color(0xFF163126);

  static const Color _textPrimaryLight = Color(0xFF0F172A);
  static const Color _textSecondaryLight = Color(0xFF4B5563);

  static const Color _textPrimaryDark = Color(0xFFF3F4F6);
  static const Color _textSecondaryDark = Color(0xFF9CA3AF);

  static ThemeData lightTheme({bool comfortMode = false}) {
    final bodyLargeSize = comfortMode ? 18.0 : 16.0;
    final bodyMediumSize = comfortMode ? 16.0 : 14.0;
    final titleLargeSize = comfortMode ? 22.0 : 20.0;
    final titleMediumSize = comfortMode ? 18.0 : 16.0;
    final borderRadius = comfortMode ? 20.0 : 18.0;
    final scheme = const ColorScheme.light(
      primary: _primary,
      secondary: _secondary,
      error: _warning,
      surface: _surfaceLight,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
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
          color: _textPrimaryLight,
        ),
        titleLarge: TextStyle(
          fontSize: titleLargeSize,
          fontWeight: FontWeight.w700,
          color: _textPrimaryLight,
        ),
        titleMedium: TextStyle(
          fontSize: titleMediumSize,
          fontWeight: FontWeight.w600,
          color: _textPrimaryLight,
        ),
        bodyLarge: TextStyle(
          fontSize: bodyLargeSize,
          fontWeight: FontWeight.w500,
          color: _textSecondaryLight,
        ),
        bodyMedium: TextStyle(
          fontSize: bodyMediumSize,
          fontWeight: FontWeight.w500,
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
          side: const BorderSide(color: Color(0xFFDDEFE5)),
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: _primary, width: 1.4),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: comfortMode ? 76 : 64,
        elevation: 0,
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
        backgroundColor: _surfaceLight,
        selectedItemColor: _primary,
        unselectedItemColor: _textSecondaryLight,
        elevation: 0,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF111827),
        contentTextStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  static ThemeData darkTheme({bool comfortMode = false}) {
    final bodyLargeSize = comfortMode ? 18.0 : 16.0;
    final bodyMediumSize = comfortMode ? 16.0 : 14.0;
    final titleLargeSize = comfortMode ? 22.0 : 20.0;
    final titleMediumSize = comfortMode ? 18.0 : 16.0;
    final borderRadius = comfortMode ? 20.0 : 18.0;
    final scheme = const ColorScheme.dark(
      primary: _primary,
      secondary: _secondary,
      error: _warning,
      surface: _surfaceDark,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
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
          color: _textPrimaryDark,
        ),
        titleLarge: TextStyle(
          fontSize: titleLargeSize,
          fontWeight: FontWeight.w700,
          color: _textPrimaryDark,
        ),
        titleMedium: TextStyle(
          fontSize: titleMediumSize,
          fontWeight: FontWeight.w600,
          color: _textPrimaryDark,
        ),
        bodyLarge: TextStyle(
          fontSize: bodyLargeSize,
          fontWeight: FontWeight.w500,
          color: _textSecondaryDark,
        ),
        bodyMedium: TextStyle(
          fontSize: bodyMediumSize,
          fontWeight: FontWeight.w500,
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
          side: const BorderSide(color: Color(0xFF1E3A2A)),
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: _primary, width: 1.4),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: comfortMode ? 76 : 64,
        elevation: 0,
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
        backgroundColor: _surfaceDark,
        selectedItemColor: _primary,
        unselectedItemColor: _textSecondaryDark,
        elevation: 0,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: _surfaceVariantDark,
        contentTextStyle: const TextStyle(color: _textPrimaryDark),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
