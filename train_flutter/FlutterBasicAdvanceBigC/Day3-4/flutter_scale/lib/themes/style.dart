import 'package:flutter/material.dart';
import 'package:flutter_scale/themes/colors.dart';

ThemeData appTheme() {
  return ThemeData(
    fontFamily: 'NotoSansThai',           // ให้ theme เป็น font NotoSansThai
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,      // สีของ AppBar ของ scaffold
      foregroundColor: secondaryTextColor,  // สีของ font ตัวหนังสือใน AppBar ของ scaffold
    ),
    scaffoldBackgroundColor: secondaryTextColor, // สีพื้นหลัง scaffold
    textTheme: const TextTheme(   // ตั้งค่า theme font
      bodyMedium: TextStyle(      // กำหนด TextStyle ของ scaffold
        color: primaryTextColor   // สี font ของ body scaffold
      )
    ),
  );
}