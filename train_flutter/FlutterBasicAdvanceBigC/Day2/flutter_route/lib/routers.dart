import 'package:flutter/material.dart';
import 'package:flutter_route/about.dart';
import 'package:flutter_route/home.dart';

// สร้างตัวแปรแบบ Object Map ไว้เก็บ Key เก็บ URL และ Value เก็บ Screen

// String คือ ชื่อ Url และ WidgetBuilder จะสามารถเรียกใช้ context ได้
Map<String, WidgetBuilder> routers = {
  "/home":(BuildContext context) => const HomeScreen(),
  "/about":(BuildContext context) => const AboutScreen(),
};