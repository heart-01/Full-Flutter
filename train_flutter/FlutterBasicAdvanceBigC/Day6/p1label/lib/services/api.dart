import 'dart:convert';
import 'package:flutter/services.dart';

class CallAPI {
  
  // สร้าง method read json
  Future<List> readProduct(barcode) async {
    final resonse = await rootBundle.loadString('assets/data/products.json'); // โหลดไฟล์ json
    final data = await json.decode(resonse); // แปลง String Json ไปเป็น Object เพื่อให้สามารถนำข้อมูลมาใช้งาน
    return data;
  }

}