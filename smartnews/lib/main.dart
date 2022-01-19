import 'package:flutter/material.dart';
import 'package:smart_news/Themes/app_theme.dart';
import 'package:smart_news/routers.dart';

// สร้างตัวแปรไว้เก็บ ULR หน้าหลัก
var initURL;

void main(){

  initURL = '/dashboard';

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme.copyWith(
        scaffoldBackgroundColor: Theme.of(context).cardTheme.color
      ),
      initialRoute: initURL,
      routes: routes,
    );
  }
}