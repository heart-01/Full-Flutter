import 'package:flutter/material.dart';
import 'package:flutter_scale/routers.dart';
import 'package:flutter_scale/themes/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

dynamic userStep;

void main() async {

  WidgetsFlutterBinding.ensureInitialized(); 

  // สร้าง Object sharedprefference เพื่อจะดึงข้อมูลที่อยู่ใน localstorage 
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  userStep = sharedPreferences.getInt('userStep'); // ดึงข้อมูล userStep ที่อยู่ใน localstorage ต้อง get ข้อมูลตาม dataType

  runApp(
    const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
    
      initialRoute: (userStep == 1) ? '/dashboard' : '/welcome' ,
      routes: routes,
    );
  }
}