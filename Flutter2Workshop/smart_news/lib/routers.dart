//สร้างตัวแปร Map Object key value ไว้เก็บ URL และ Screen
import 'package:flutter/material.dart';
import 'package:smart_news/Screens/Dashboard/dashboard_screen.dart';
import 'package:smart_news/Screens/Drawermenu/aboutus_screen.dart';
import 'package:smart_news/Screens/Drawermenu/category_screen.dart';
import 'package:smart_news/Screens/Drawermenu/latest_news_list_screen.dart';
import 'package:smart_news/Screens/Drawermenu/setting_screen.dart';
import 'package:smart_news/Screens/Drawermenu/video_list_screen.dart';

Map<String, WidgetBuilder> routes = {
  "/dashboard": (BuildContext context) => const DashboardScreen(),
  "/lastest_news": (BuildContext context) => const LatestNewsListScreen(),
  "/category": (BuildContext context) => const CategoryScreen(),
  "/videolist": (BuildContext context) => const VideoListScreen(),
  "/about": (BuildContext context) => const AboutUsScreen(),
  "/setting": (BuildContext context) => const SettingScreen(),
};