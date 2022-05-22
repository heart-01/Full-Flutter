import 'package:flutter/material.dart';
import 'package:flutter_route/themes/color.dart';

ThemeData appTheme() {
  return ThemeData(
    fontFamily: 'NotoSansThai', // ให้ theme เป็น font NotoSansThai
    appBarTheme: const AppBarTheme(color: primaryColor), // สีของ AppBar ของ scaffold
    scaffoldBackgroundColor: secondaryTextColor, // สีพื้นหลัง scaffold
    textTheme: const TextTheme(   // ตั้งค่า theme font
      bodyMedium: TextStyle(      // กำหนด TextStyle ของ scaffold
        color: primaryTextColor // สี font ของ body scaffold
      )
    ),

    // colorScheme: ColorScheme.fromSwatch(
      // primarySwatch: primaryColor,
    //   accentColor: primaryColor
    // ),
  );
}