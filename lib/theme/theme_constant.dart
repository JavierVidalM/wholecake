import 'package:flutter/material.dart';

class MyTheme {
  static const Color primary = Color(0xFFFFC4E3);
  static final ThemeData myTheme = ThemeData(
    primaryColor: primary,
    brightness: Brightness.light,
    primarySwatch: Colors.pink,
    scaffoldBackgroundColor: Color(0xFFBDE0FE),
    appBarTheme: const AppBarTheme(color: primary),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(backgroundColor: Color(0xFF5D2A42))),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF5D2A42),
    ),
  );
}
