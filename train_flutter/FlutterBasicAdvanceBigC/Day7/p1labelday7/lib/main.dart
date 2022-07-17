// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p1label/provider/app_locale.dart';
import 'package:p1label/routers.dart';
import 'package:p1label/themes/styles.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// แสดงภาษาต่าง ๆ จะ import ในหน้าที่จะใช้งานการเปลี่ยนภาษา
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

var userStep;

void main() async {

  WidgetsFlutterBinding.ensureInitialized(); // ทำให้ function main มีความสามารถ async ได้
  // สร้าง Object sharedprefference เพื่อจะดึงข้อมูลใน localstorage
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  userStep = sharedPreferences.getInt('userStep');

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider( // เมื่อเราใช้ provider ต้อง wrap ด้วย ChangeNotifierProvider
      create: (context) => AppLocale(), // เรียกใช้ ChangeNotifier
      child: Consumer<AppLocale>(builder: (context, proviLocale, child) { // เรียกใช้ Consumer Provider ของ Class AppLocale
        return MaterialApp(
          debugShowCheckedModeBanner: false,
      
          // เปลี่ยนภาษา
          localizationsDelegates: AppLocalizations.localizationsDelegates, // localizationsDelegates การแปลภาษาท้องถิ่น เรียกใช้ Class AppLocalizations 
          supportedLocales: AppLocalizations.supportedLocales, // ภาษาที่ support ในแอปเรียกใช้งาน Class AppLocalizations จะเก็บชื่อภาษาของ app ที่เราเขียนไว้ในไฟล์ .arb
          locale: proviLocale.proviLocale, // ส่งค่าใหม่ไปให้ Provider รู้
      
          theme: appTheme(),
          initialRoute: userStep == 1 ? '/home' : '/branchcode',
          routes: routes,
        );
      }),
    );
  }
}