import 'package:flutter/material.dart';

class AppLocale extends ChangeNotifier { // ChangeNotifier จะเป็นตัวเปลี่ยนนเฉพาะจุด
  Locale _locale = const Locale('en'); // Locale เป็น package flutter_localizations ที่มาจาก dart
  
  Locale get proviLocale => _locale; 

  void changeLocale(Locale newLocale){ // function เปลี่ยนภาษา
    _locale = newLocale;
    notifyListeners(); // เป็นตัวแทนการ setState ปกติจะ Render ทั้งหน้าจอ แต่ notifyListeners จะเปลี่ยนแปลงแค่เฉพาะตัวแปรที่อยู่ใน function changeLocale เท่านั้น ก็คือตัวแปร _locale
  }

}