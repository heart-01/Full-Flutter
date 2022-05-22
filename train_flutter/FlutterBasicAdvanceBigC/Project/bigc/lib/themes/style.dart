import 'package:bigc/themes/colors.dart';
import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    fontFamily: 'NotoSansThai',           
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,      
      foregroundColor: whiteColor, 
    ),
    scaffoldBackgroundColor: whiteColor,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(    
        color: blackColor
      ),
    ),
  );
}