import 'package:flutter/material.dart';
import 'package:wholecake/sidebar.dart';

class SweetCakeTheme {
  static const Color white = Color(0xFFF0F0F0);
  static const Color pink1 = Color(0xFFFFC4E3);
  static const Color pink2 = Color(0xFFFFB5D7);
  static const Color pink3 = Color(0xFF5D2A42);
  static const Color blue = Color(0xFFBDE0FE);
  static const Color blue2 = Color(0xFF3681AB);
  static const Color hint = Color(0xFF909090);
  // static const Color SBicons = Color(0xFFA1A1A1);

  static final ThemeData nadena = ThemeData();

  static final ThemeData loginTheme = ThemeData(
    scaffoldBackgroundColor: blue,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(pink2),
        // overlayColor: MaterialStateProperty.all<Color>(SweetCakeTheme.pink2),
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: white, fontSize: 22),
      bodyMedium: TextStyle(color: blue2, fontSize: 20),
      bodySmall: TextStyle(color: hint, fontSize: 18),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(blue2),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(color: hint, fontSize: 20),
      fillColor: blue,
      filled: true,
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: blue2, width: 2.0)),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: blue2, width: 4.0)),
    ),
  );

  static final ThemeData mainTheme = ThemeData(
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
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(pink2),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        foregroundColor: MaterialStateProperty.all<Color>(pink3),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: pink2,
      foregroundColor: pink3,
    ),
    cardTheme: CardTheme(
      color: const Color(0xFFBDE0FE),
      elevation: 10,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
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
    ),
  );

  static final ThemeData graphCardTheme = ThemeData(
      cardTheme: CardTheme(
        color: const Color(0xFF343434),
        elevation: 10,
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      textTheme: const TextTheme(
          bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      )));

  static ThemeData sidebarTheme = ThemeData(
      primaryColor: pink1,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      textTheme: const TextTheme(
        bodyText1: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        bodyText2: TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        subtitle1: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        subtitle2: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
      // dividerColor: Colors.black,
      tabBarTheme: const TabBarTheme(
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Color(0xFFFFC4E3),
      ),
      colorScheme: ColorScheme.light(primary: pink2));
}
