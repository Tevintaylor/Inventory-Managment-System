import 'package:flutter/material.dart';

class ThemeConfig {
  // static Color lightPrimary = Colors.white;
  // static Color darkPrimary = Color(0xff1f1f1f);
  // static Color lightAccent = Color(0xff06d6a7);
  // static Color darkAccent = Color(0xff06d6a7);
  // static Color lightBG = Colors.white;
  // static Color darkBG = Color(0xff121212);

  //Colors for theme
  static Color lightPrimary = Colors.white;
  static Color darkPrimary = Colors.white10;
  static Color lightAccent = Colors.lightBlue;
  static Color darkAccent = Colors.lightBlueAccent[700];
  static Color lightBG = Colors.white;
  static Color darkBG = Colors.grey[800];

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    cursorColor: lightAccent,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      elevation: 0,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkPrimary,
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkPrimary,
    appBarTheme: AppBarTheme(
      elevation: 0,
    ),
  );
}
