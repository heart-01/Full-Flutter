import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterlayout/centerlayout.dart';
import 'package:flutterlayout/containerlayout.dart';
import 'package:flutterlayout/expandlayout.dart';
import 'package:flutterlayout/rowcolumnlayout.dart';
import 'package:flutterlayout/stacklayout.dart';
import 'package:flutterlayout/WelcomeScreen/welcomescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // กำหนดคำสั่งตั้งค่าล็อก Screen เป็นแนวที่กำหนดไว้จะถูกล็กไว้ทั้งแอป ถ้าเอาเฉพาะหน้าต้องไปใส่ไว้ในหน้านั้น
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp 
        // DeviceOrientation.portraitDown
        // DeviceOrientation.landscapeLeft
        // DeviceOrientation.landscapeRight
      ]
    );

    return const MaterialApp(
      // home: CenterLayout(),
      // home: ContainerLayout(),
      // home: RowColumnLayout(),
      // home: StackLayout(),
      // home: ExpandLayout(),
      home: WelcomeScreen(),
    );
  }
}