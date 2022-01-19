import 'package:flutter/material.dart';
import 'package:water_bill/Screens/HomePage/HomePage.dart';
import 'package:water_bill/Screens/Login/LoginScreen.dart';
import 'package:water_bill/Screens/SettingPage/SettingPage.dart';
import 'package:water_bill/Screens/SettingTheme/SettingTheme.dart';

Map<String, WidgetBuilder> routes = {
  "/HomePage": (BuildContext context) => HomePage(),
  "/LoginScreen": (BuildContext context) => LoginScreen(),
  "/SettingPage": (BuildContext context) => SettingPage(),
  "/SettingTheme": (BuildContext context) => SettingTheme(),
  
};