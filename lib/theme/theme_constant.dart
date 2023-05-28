import 'package:flutter/material.dart';

class SweetCakeTheme {
  static const Color white = Color(0xFFF0F0F0);
  static const Color pink1 = Color(0xFFFFC4E3);
  static const Color pink2 = Color(0xFFFFB5D7);
  static const Color pink3 = Color(0xFF5D2A42);
  static const Color blue = Color(0xFFBDE0FE);
  static const Color blue2 = Color(0xFF3681AB);
  static const Color hint = Color(0xFF909090);
  static const Color gray = Color(0xFF454545);
  static const Color warning = Color(0xFFF95959);
  static const Color graphBG = Color(0xFF343434);

  // static const Color SBicons = Color(0xFFA1A1A1);

  static MaterialColor pink_1 = const MaterialColor(
    0xFFFFB5D7, // color principal
    <int, Color>{
      50: Color(0xFFFFE3EE),
      100: Color(0xFFFFC1D1),
      200: Color(0xFFFF9FB4),
      300: Color(0xFFFF7D97),
      400: Color(0xFFFF5B7B),
      500: Color(0xFFFF3A5E),
      600: Color(0xFFFF3257),
      700: Color(0xFFFF2A4E),
      800: Color(0xFFFF2247),
      900: Color(0xFFFF1539),
    },
  );

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
      titleMedium: TextStyle(color: gray, fontSize: 20),
      titleSmall: TextStyle(color: hint, fontSize: 18),
      bodyLarge: TextStyle(color: blue2, fontSize: 22),
      bodyMedium: TextStyle(color: blue2, fontSize: 20),
      bodySmall: TextStyle(color: gray, fontSize: 16),
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
    snackBarTheme: const SnackBarThemeData(
        backgroundColor: blue2,
        closeIconColor: Colors.white,
        contentTextStyle: TextStyle(color: white),
        behavior: SnackBarBehavior.floating),
  );

  static ThemeData sidebarTheme = ThemeData(
    primaryColor: pink1,
    // secondaryHeaderColor: pink2,
    iconTheme: const IconThemeData(
      color: gray,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: gray,
        fontSize: 16,
      ),
    ),
    // dividerColor: gray,
    drawerTheme: const DrawerThemeData(
      backgroundColor: pink1,
    ),
    listTileTheme: const ListTileThemeData(
        iconColor: gray,
        textColor: gray,
        selectedColor: pink2,
        tileColor: pink1),
    expansionTileTheme: const ExpansionTileThemeData(
      iconColor: pink3,
      textColor: pink3,
      backgroundColor: pink2,
      collapsedBackgroundColor: pink1,
      collapsedIconColor: gray,
      collapsedTextColor: gray,
    ),
    colorScheme: const ColorScheme.light(primary: pink2),
    dividerTheme: const DividerThemeData(
      color: gray,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );

  static final ThemeData mainTheme = ThemeData(
    //Color principal
    primaryColor: pink1,
    //Tema para el appbar
    appBarTheme: const AppBarTheme(
      color: pink2,
      iconTheme: IconThemeData(color: pink3),
      centerTitle: true,
      titleSpacing: 0,
    ),
    //Estilo de los textos
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: pink3, fontSize: 28),
      bodyMedium:
          TextStyle(color: gray, fontSize: 16, fontWeight: FontWeight.bold),
      bodySmall: TextStyle(color: gray, fontSize: 14),
    ),
    //Color de fondo de la app
    scaffoldBackgroundColor: blue,
    //Estilo de los botones tradicionales
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
    //Estilo de los botones flotantes
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: pink2,
      foregroundColor: pink3,
    ),
    //Estilo de las Cards
    cardTheme: CardTheme(
      color: const Color(0xFFBDE0FE),
      elevation: 10,
      shadowColor: blue2,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    //Estilo de las entradas de texto
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
    iconTheme: const IconThemeData(color: blue2),
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: pink2),
    // Estilo para el AlertDialog (PopUP)
    dialogTheme: DialogTheme(
      backgroundColor: blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    chipTheme: const ChipThemeData(
        backgroundColor: SweetCakeTheme.pink2,
        selectedColor: pink1,
        checkmarkColor: pink3,
        labelStyle: TextStyle(color: pink3, fontWeight: FontWeight.w600)),
  );

  static final ThemeData searchBarTheme = ThemeData(
    listTileTheme: const ListTileThemeData(tileColor: blue),
  );

  static final ThemeData calendarTheme = ThemeData(
    primarySwatch: pink_1,
    dialogBackgroundColor: blue,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(blue2),
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
    dropdownMenuTheme: DropdownMenuThemeData(
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
        menuStyle: MenuStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
        textStyle: const TextStyle(color: Colors.red)),
  );

  static final ThemeData graphCardTheme = ThemeData(
    cardTheme: CardTheme(
      color: graphBG,
      elevation: 10,
      shadowColor: blue2,
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
      ),
    ),
  );
}
