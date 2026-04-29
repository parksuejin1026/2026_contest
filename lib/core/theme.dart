import 'package:flutter/material.dart';

class AppTheme {
  // 1. Soft Blue & White (Diagnostic & Landing)
  static const Color softBlue = Color(0xFFE3F2FD);
  static const Color primaryBlue = Color(0xFF1E88E5);
  static const Color pastelAccent = Color(0xFFFFF3E0); // Peach/Pastel orange accent
  static const Color textLight = Color(0xFF2C3E50);
  
  // 2. Deep Navy & Neon (Analytics Dashboard)
  static const Color deepNavy = Color(0xFF0A0E21);
  static const Color neonCyan = Color(0xFF00E5FF);
  static const Color neonPink = Color(0xFFFF007F);
  static const Color neonGreen = Color(0xFF00E676);
  static const Color darkSurface = Color(0xFF111536);

  // Text styles
  static const TextTheme _textTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.w900, letterSpacing: -1.5),
    displayMedium: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, letterSpacing: -0.5),
    titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
  );

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryBlue,
      brightness: Brightness.light,
      background: Colors.white,
    ),
    textTheme: _textTheme.apply(
      bodyColor: textLight,
      displayColor: textLight,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: textLight,
    ),
    cardTheme: const CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: deepNavy,
    colorScheme: ColorScheme.fromSeed(
      seedColor: deepNavy,
      brightness: Brightness.dark,
      primary: neonCyan,
      secondary: neonPink,
      background: deepNavy,
      surface: darkSurface,
    ),
    textTheme: _textTheme.apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
    ),
    cardTheme: const CardThemeData(
      elevation: 0,
      color: darkSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: neonCyan,
        foregroundColor: deepNavy,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
