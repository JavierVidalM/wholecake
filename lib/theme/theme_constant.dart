import 'package:flutter/material.dart';

class SweetCakeTheme {
  static const Color pink1 = Color(0xFFFFC4E3);
  static const Color pink2 = Color(0xFFFFB5D7);
  static const Color pink3 = Color(0xFF5D2A42);
  static const Color blue = Color(0xFFBDE0FE);
  static const Color hint = Color(0xFFA1A1A1);

  static final InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
    hintStyle: const TextStyle(
      color: hint,
      fontSize: 14,
    ),
    fillColor: Colors.white,
    filled: true,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10),
    ),
  );

  static final ThemeData myTheme = ThemeData(
    primaryColor: pink1,
    appBarTheme: const AppBarTheme(
      color: pink2,
      iconTheme: IconThemeData(color: pink3),
      centerTitle: true,
      titleSpacing: 0,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: pink3, fontSize: 28),
      bodyMedium:
          TextStyle(color: pink3, fontSize: 18, fontWeight: FontWeight.bold),
      bodySmall: TextStyle(color: Colors.grey),
    ),
    scaffoldBackgroundColor: blue,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(pink2),
        foregroundColor: MaterialStateProperty.all<Color>(pink3),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(pink2),
        foregroundColor: MaterialStateProperty.all<Color>(pink3),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: pink2,
      foregroundColor: pink3,
    ),
    inputDecorationTheme: _inputDecorationTheme,
  );
}
