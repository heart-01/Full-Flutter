import 'package:flutter/material.dart';
import 'package:smart_news/Screens/Dashboard/DashboardScreen.dart';
import 'package:smart_news/Screens/Drawermenu/AboutUsScreen.dart';
import 'package:smart_news/Screens/Drawermenu/CategoryScreen.dart';
import 'package:smart_news/Screens/Drawermenu/LatestNewsListScreen.dart';
import 'package:smart_news/Screens/Drawermenu/SettingScreen.dart';
import 'package:smart_news/Screens/Drawermenu/VideoListScreen.dart';
import 'package:smart_news/Screens/Login/LoginScreen.dart';
import 'package:smart_news/Screens/NewsDetail/NewsDetail.dart';

// สร้างตัวแปร Map ไว้เก็บ URL และ Screen
Map<String, WidgetBuilder> routes = {
  "/login":(BuildContext context) => LoginScreen(),
  "/dashboard":(BuildContext context) => DashboardScreen(),
  "/lastest_news":(BuildContext context) => LatestNewsListScreen(),
  "/category":(BuildContext context) => CategoryScreen(),
  "/videolist":(BuildContext context) => VideoListScreen(),
  "/about":(BuildContext context) => AboutUsScreen(),
  "/setting":(BuildContext context) => SettingScreen(),
  "/newsdetail":(BuildContext context) => NewsDetail(),
};