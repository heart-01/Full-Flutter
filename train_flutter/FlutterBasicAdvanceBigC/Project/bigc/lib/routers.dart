import 'package:bigc/screens/branch/branch_screen.dart';
import 'package:bigc/screens/home/home_screen.dart';
import 'package:bigc/screens/print/print_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes = {
  '/home': (BuildContext context) => const HomeScreen(),
  '/branch': (BuildContext context) => const BranchScreen(),
  '/print-screen': (BuildContext context) => const PrintScreen(),
};