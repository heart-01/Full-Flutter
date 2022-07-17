// เราควรที่จะรวมตัวแปร SharedPreferences มาไว้ในหน้านี้
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

const String selectedLang = "selectedLang";

// function set ตัวแปรแบบ SharedPreferences
Future setLocale(String languageCode) async {
  // สร้าง Object _pref เพื่อจะเก็บข้อมูลใน localstorage
  SharedPreferences _pref = await SharedPreferences.getInstance();
  // เก็บข้อมูล selectedLang ลงใน localstorage
  await _pref.setString(selectedLang, selectedLang);
}

// function get ตัวแปรแบบ SharedPreferences
Future<Locale> getLocale() async {
  // สร้าง Object _pref เพื่อจะแสดงข้อมูลใน localstorage
  SharedPreferences _pref = await SharedPreferences.getInstance();
  // แสดงข้อมูล selectedLang ใน localstorage ถ้า selectedLang เป็นค่า null กำหนดให้เป็นค่า en
  String languageCode = _pref.getString(selectedLang) ?? 'en';
  return Locale(languageCode);
}
