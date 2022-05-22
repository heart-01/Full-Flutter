import 'package:flutter/material.dart';
import 'package:flutter_route/home.dart';
import 'package:flutter_route/routers.dart';
import 'package:flutter_route/themes/style.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme(),
      initialRoute: '/home',
      routes: routers,
    );
  }
}