// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:p1label/demolocalization/demo_localization.dart';
import 'package:p1label/screens/branchcode/branchcode_screen.dart';
import 'package:p1label/screens/home/home_screen.dart';
import 'package:p1label/screens/physicalkeyboard/physical_screen.dart';
import 'package:p1label/screens/print/print_screen.dart';

// สร้างตัวแปรแบบ Map
Map<String,WidgetBuilder> routes = {
  "/branchcode": (BuildContext context) => BranchCodeScreen(),
  "/home": (BuildContext context) => HomeScreen(),
  '/print-screen': (BuildContext context) => PrintScreen(),
  '/physicalkey': (BuildContext context) => PhysicalKeyboardScreen(),
  '/localization': (BuildContext context) => DemoLocalizationScreen(),
};