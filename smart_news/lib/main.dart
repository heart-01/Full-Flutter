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
  const MyApp({Key? key}) : super(key: key); // constructors มักจะโยน variable เข้ามาใน Class แล้วกำหนดให้กับ property

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {  // BuildContext เป็นสิ่งที่ใช้สำหรับบ่งบอกตำแหน่งของ Widget บน Widget Tree // Context นอกจากจะถูกใช้เพื่อบอกตำแหน่งว่าเป็น Widget ตัวไหน และอยู่ส่วนไหนของ Widget Tree แล้ว ยังถูกใช้สำหรับเก็บข้อมูลของ flutter ที่มีลักษณะ Global เช่น Class ตั้งต้น ของ Widget ต่าง ๆ
    return MaterialApp( //Widget MaterialApp เรียกหน้าจอออกมา
      theme: AppTheme.lightTheme.copyWith( //เรียก Class AppTheme ดึง method lightTheme จากไฟล์ app_theme และ copyWith คุณสมบัติจาก lightTheme มาเพื่อจะเรียกตั้งค่าสี Theme บางส่วนที่ flutter ไม่ได้ bulid theme ให้อัติโนมัติ ส่วนตัวที่ไม่ได้ตั้งค่า flutter จะ bulid theme ให้โดยอัติโนมัติอยู่แล้ว
        scaffoldBackgroundColor: Theme.of(context).cardTheme.color // ตั้งค่าสี scaffoldBackgroundColor โดยเรียก color จาก property cardTheme จาก Method lightTheme // Theme.of(context) นั้นเปรียบได้กับการดึงข้อมูล ThemeData ที่ถูกส่งมาให้โดย MaterialApp
      ),
      
      // home: Scaffold(
      //   body: DashboardScreen(),
      // ),

      initialRoute: initURL, //หน้าแรกที่ให้ routes เมื่อเปิดแอป
      routes: routes, //เชื่อม routes กับ main

    );
  }
}