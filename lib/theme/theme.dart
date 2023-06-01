import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 22),
      iconTheme: IconThemeData(
        color: Colors.purple,
      ),
    ),
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    textTheme: GoogleFonts.poppinsTextTheme(),
    buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      buttonColor: Colors.black,
    ),
    colorScheme: const ColorScheme.light().copyWith(
      primary: Colors.purple,
    ),
    highlightColor: Colors.white,
    hintColor: const Color(0xFF9E9E9E),
    disabledColor: const Color(0xFF343A40),
  );
}
