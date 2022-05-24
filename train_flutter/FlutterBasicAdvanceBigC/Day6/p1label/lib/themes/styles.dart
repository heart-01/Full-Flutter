import 'package:flutter/material.dart';
import 'package:p1label/themes/colors.dart';

ThemeData appTheme() {
  return ThemeData(
    fontFamily: 'IBMPlexSansThaiLooped',
    primaryColor: primaryColor,
    errorColor: Colors.red,
    hoverColor: Colors.grey,
    colorScheme: const ColorScheme.light(primary: primaryColor),
    cardTheme: const CardTheme(color: Colors.white),
    iconTheme: const IconThemeData(color: textColorPrimary),
    textTheme: const TextTheme(
      button: TextStyle(color: primaryColor),
      headline6: TextStyle(color: textColorPrimary),
      bodyText1: TextStyle(color: white_color),
      subtitle2: TextStyle(color: textColorSecondary),
    ),
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white),
    scaffoldBackgroundColor: white_color,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: white_color,
      iconTheme: IconThemeData(color: white_color),
      titleTextStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700)
    )
  );
}