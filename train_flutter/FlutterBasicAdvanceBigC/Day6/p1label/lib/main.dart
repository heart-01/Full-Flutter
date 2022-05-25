// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:p1label/routers.dart';
import 'package:p1label/themes/styles.dart';

var initURL;

void main() {

  // initURL = '/branchcode';
  initURL = '/print-screen';

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      initialRoute: initURL,
      routes: routes,
    );
  }
}