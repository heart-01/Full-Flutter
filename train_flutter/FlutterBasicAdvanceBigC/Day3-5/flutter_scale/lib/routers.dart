import 'package:flutter/material.dart';
import 'package:flutter_scale/screens/addproduct/addproduct_screen.dart';
import 'package:flutter_scale/screens/dashboard/dashboard_screen.dart';
import 'package:flutter_scale/screens/login/login_screen.dart';
import 'package:flutter_scale/screens/newsdetail/news_detail.dart';
import 'package:flutter_scale/screens/register/register_screen.dart';
import 'package:flutter_scale/screens/welcome/welcome_screen.dart';

//สร้างตัวแปร Map route
Map<String, WidgetBuilder> routes = {
  '/welcome': (BuildContext context) => const WelcomeScreen(),
  '/login': (BuildContext context) => const LoginScreen(),
  '/register': (BuildContext context) => const RegisterScreen(),
  '/dashboard': (BuildContext context) => const DashboardScreen(),
  '/newsdetail': (BuildContext context) => NewsDetailScreen(),
  '/addproduct': (BuildContext context) => const AddProductScreen(),
};