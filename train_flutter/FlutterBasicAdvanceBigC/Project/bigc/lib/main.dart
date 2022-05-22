import 'package:bigc/routers.dart';
import 'package:bigc/themes/style.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
    
      initialRoute: '/home',
      // initialRoute: '/branch',
      // initialRoute: '/print-screen',
      routes: routes,
    );
  }
}
