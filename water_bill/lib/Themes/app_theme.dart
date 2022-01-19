import 'package:flutter/material.dart';
import 'package:water_bill/Themes/colors.dart';

class AppTheme {
  get darkTheme => ThemeData(
    fontFamily: 'Kanit',
    primarySwatch: Colors.grey,
    appBarTheme: AppBarTheme(
        brightness: Brightness.dark, color: AppColors.textBlack),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: AppColors.textGrey),
      labelStyle: TextStyle(color: AppColors.white),
    ),
    brightness: Brightness.dark,
    canvasColor: AppColors.lightGreyDarkMode,
    accentColor: AppColors.darkPink,
    accentIconTheme: IconThemeData(color: Colors.white),
  );

  get lightTheme => ThemeData(
    fontFamily: 'Kanit',
    primarySwatch: Colors.grey,
    appBarTheme:
        AppBarTheme(brightness: Brightness.light, color: AppColors.grey2,),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: AppColors.textGrey),
      labelStyle: TextStyle(color: AppColors.white),
    ),
    canvasColor: AppColors.white,
    brightness: Brightness.light,
    accentColor: AppColors.grey2,
    accentIconTheme: IconThemeData(color: Colors.black),
  );
}
