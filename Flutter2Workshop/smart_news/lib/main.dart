import 'package:flutter/material.dart';
import 'package:smart_news/routers.dart';

import 'Themes/app_theme.dart';

var initURL;
void main() {
  initURL = '/dashboard';

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      theme: AppTheme.lightTheme.copyWith(
        scaffoldBackgroundColor: Theme.of(context).cardTheme.color,
      ),

      initialRoute: initURL,
      routes: routes,

    );
  }
}
