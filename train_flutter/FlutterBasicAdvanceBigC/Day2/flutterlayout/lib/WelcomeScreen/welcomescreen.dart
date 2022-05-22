import 'package:flutter/material.dart';
import 'package:flutterlayout/WelcomeScreen/buttonstart.dart';
import 'package:flutterlayout/WelcomeScreen/textheader.dart';
import 'package:flutterlayout/WelcomeScreen/textwelcome.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({ Key? key }) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(  //ตกแต่ง Container
          gradient: LinearGradient(       // ไล่สีพื้นหลังของ Container
            colors: [Colors.blue, Colors.teal],
            begin: Alignment.topLeft,     // เริ่มไล่สีจากด้านบนซ้าย ไปถึงล่างขวา
            end: Alignment.bottomRight,
            tileMode: TileMode.repeated   // โหมดการไล่สีใช้แบบ repeated
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            // Header
            TextHeader(),
            // Welcome text
            TextWelcome(),
            // Button
            ButtonStart()
          ],
        ),

      ),
    );
  }
}