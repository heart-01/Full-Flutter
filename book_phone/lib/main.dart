import 'package:book_phone/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp()); //Widget runApp สั่งให้เรียกใช้งานเริ่มต้น
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //GestureDetector จะเป็นการสร้าง Event ที่ใช้ method ต่าง ๆ เข้ามาตรวจสอบ Touch Screen
      onTap: () {
        FocusScope.of(context).unfocus();
        print('touch screen');
      },
      child: MaterialApp(
        //Widget MaterialApp เรียกหน้าจอออกมา
        title: 'แอปสมุดโทรศัพท์',
        theme: ThemeData(
          textTheme: GoogleFonts.maliTextTheme(
            Theme.of(context).textTheme,
          ), //Font จาก library pub dev
          appBarTheme: AppBarTheme(
            textTheme: GoogleFonts.maliTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
