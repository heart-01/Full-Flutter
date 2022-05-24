import 'package:flutter/material.dart';
import 'package:p1label/screens/audioplayer/audioplayer.dart';
import 'package:p1label/screens/branchcode/branchcode_screen.dart';
import 'package:p1label/screens/home/home_screen.dart';
import 'package:p1label/screens/print/print_screen.dart';

// สร้างตัวแปรแบบ Map
Map<String,WidgetBuilder> routes = {
  "/branchcode": (BuildContext context) => BranchCodeScreen(),
  "/home": (BuildContext context) => HomeScreen(),
  "/print-screen": (BuildContext context) => const PrintScreen(),
  "/audioplayer": (BuildContext context) => const AudioPlayerScreen(),
};