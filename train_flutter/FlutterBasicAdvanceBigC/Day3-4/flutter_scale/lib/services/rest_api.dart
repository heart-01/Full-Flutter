import 'dart:convert';

import 'package:flutter_scale/models/NewsModel.dart';
import 'package:flutter_scale/utils/constants.dart' as constant;
import 'package:http/http.dart' as http;

class CallAPI {
  // กำหนด header ของ API
  _setHeaders() => {
    'Content-Type': 'application/json', 
    'Accept': 'application/json'
  };

  //Login Auth return เป็น data json
  loginAPI(data) async { //function async
    return await http.post(
      //Uri เป็น function ที่แปลง url เป็น string เพราะ ใน flutter จะไม่มอง url เป็น string
      Uri.parse(constant.baseAPIURL + 'login'), 
      headers: _setHeaders(),
      body: jsonEncode(data),
    );
  }

  //API อ่านข่าวล่าสุด
  //Future คือ  รูปแบบการีเทิร์นข้อมูลที่มีการรอคอยว่าข้อมูลที่ตอบกลับมาคืออะไร
  //ด้านใน <> คือ class model พอได้ข้อมูลจาก Future กลับแล้วเราก็จะโยนใส่กล่อง model
  //ใน model จะมีการ return ค่ากลับมาเป็นแบบ List เราต้องใส่ type ให้ด้วย แล้วเอาข้อมูลใน list กับไปวน loop ออกมา
  //ข้อมูลใน List model อาจจะไม่มีข้อมูลก็ได้เราต้องใส่ ? ให้ด้วย
  Future<List<NewsModel>?>  getAllNews() async { //Future function return ค่าเป็น Model
    var response = await http.get(
      Uri.parse(constant.baseAPIURL + 'news'), 
      headers: _setHeaders(),
    );

    //จับค่าที่ได้จาก api ใส่เข้าไปใน class model method newsModelFromJson แล้ว return ออกไป
    return (response.body != null) ? newsModelFromJson(response.body) : null ;
  }



}