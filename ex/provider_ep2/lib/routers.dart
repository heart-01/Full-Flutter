import 'package:flutter/material.dart';
import 'package:provi/screen/form_screen.dart';
import 'package:provi/screen/home.dart';

//สร้างตัวแปร Map Object key value ไว้เก็บ URL และ Screen
Map<String, WidgetBuilder> routes = {
  "/Home": (BuildContext context) => Home(),
  "/FormScreen": (BuildContext context) => FormScreen(),
};
