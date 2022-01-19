import 'package:flutter/material.dart';
import 'package:smart_news/Screens/Dashboard/DashboardScreen.dart';
import 'package:smart_news/Themes/app_theme.dart';
import 'package:smart_news/routers.dart';

//ตัวแปรเก็บ url 
var initURL;
void main(){

  initURL = '/dashboard'; //กำหนดค่าเริ่มต้นของตัวแปร initURL คือ dashboard

  runApp( //Widget runApp สั่งให้เรียกใช้งานเริ่มต้น
    MyApp()
  );
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) { //Widget BuildContext แยก Widget ออกมาแล้ว build เป็น context ให้ MyApp เรียกใช้
    return MaterialApp( //Widget MaterialApp เรียกหน้าจอออกมา
      theme: AppTheme.lightTheme.copyWith( //ดึง Theme จากไฟล์ app_theme
        scaffoldBackgroundColor: Theme.of(context).cardTheme.color
      ),
      
      // home: Scaffold(
      //   body: DashboardScreen(),
      // ),

      initialRoute: initURL, //หน้าแรกที่ให้ routes เมื่อเปิดแอป
      routes: routes, //เชื่อม routes กับ main

    );
  }
}