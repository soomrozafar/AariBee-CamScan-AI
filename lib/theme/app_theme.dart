import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryBlue = Color(0xff00B4D8);

  static const Color deepBlue = Color(0xff0F4C81);

  static const Color background = Color(0xff0B1220);

  static const Color surface = Color(0xff121A2A);

  static const Color white = Color(0xffF8F9FA);

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: background,
    primaryColor: primaryBlue,
    colorScheme: const ColorScheme.dark(
      primary: primaryBlue,
      secondary: deepBlue,
      surface: surface,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: background,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: white,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    ),
    cardColor: surface,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.black,
        elevation: 0,
        minimumSize: const Size(double.infinity, 58),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    ),
    textTheme: const TextTheme(bodyMedium: TextStyle(color: white)),
  );
}
