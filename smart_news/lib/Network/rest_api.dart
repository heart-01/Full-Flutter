import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_news/Models/LoginModel.dart';
import 'package:smart_news/Models/NewsDetailModel.dart';
import 'package:smart_news/Models/NewsModel.dart';
import 'package:smart_news/Utils/constant.dart';

class CallApi {
  // กำหนด header ของ API
  _setHeaders() => {
    "Content-Type": "application/json", 
    "Accept": "application/json"
  };

  // กำหนด header สำหรับ Auth
  _setHeadersAuth() => {
    "Content-Type": "application/x-www-form-urlencoded"
  };

  //Login Auth return เป็น data json
  loginCustomer(data) async { //function async
    return await http.post(
      Uri.parse(baseAPIURL + 'jwt-auth/v1/token'), //Uri เป็น function ที่แปลง url เป็น string เพราะ ใน flutter จะไม่มอง url เป็น string
      headers: _setHeadersAuth(),
      body: data
    );
  }

  //Login Auth return เป็น bool
  // Future<bool> loginCustomer(String username, String password) async { //function async
  //   var response = await http.post(
  //     Uri.parse(baseAPIURL + 'jwt-auth/v1/token'), //Uri เป็น function ที่แปลง url เป็น string เพราะ ใน flutter จะไม่มอง url เป็น string
  //     headers: _setHeadersAuth(),
  //     body: {
  //       "username": username,
  //       "password": password
  //     }
  //   );
 
  //   if(response.statusCode == 200) { //เช็ค statusCode
  //     var jsonString = response.body; //json ที่ Claa มาทั้งหมด
  //     print(jsonString);
  //     LoginModel loginModel = loginModelFromJson(jsonString); //โหลดเข้า Model
  //     print(loginModel);
      
  //     return loginModel.statusCode == 200 ? true : false; //เช็คอีกรอบว่ามีข้อมูล api อยู่
  //   }

  //   return false;
  // }

  //API อ่านข่าวล่าสุด
  //Future คือ  รูปแบบการีเทิร์นข้อมูลที่มีการรอคอยว่าข้อมูลที่ตอบกลับมาคืออะไร
  //ด้านใน <> คือ model พอได้ข้อมูลจาก Future กลับแล้วเราก็จะโยนใส่กล่อง model
  //ใน model จะมีการ return ค่ากลับมาเป็นแบบ List เราต้องใส่ type ให้ด้วย แล้วเอาข้อมูลใน list กับไปวน loop ออกมา
  //ข้อมูลใน List model อาจจะไม่มีข้อมูลก็ได้เราต้องใส่ ? ให้ด้วย
  Future<List<NewsModel>?>  getLastNews() async { //Future function return ค่าเป็น Model
    final response = await http.get(
      Uri.parse(baseAPIURL + 'wp/v2/posts?per_page=10&_embed'),
      headers: _setHeaders()
    );

    //เช็คว่ามีข้อมูลมาไหม ถ้ามีข้อมูลมา
    if(response.body.isNotEmpty){ //response.body เป็น ข้อมูลที่ดึงมาได้จาก api
      return newsModelFromJson(response.body); //จับค่าที่ได้จาก api ใส่เข้าไปใน model แล้ว return ออกไป
    }else{ //ถ้าไม่พบข้อมูล
      return null; //ส่ง null ออกไป
    }
  }

  //เขียน API เขียนข่าวตามหมวดหมู่
  Future<List<NewsModel>?>  getNewsByCategory(id) async { //Future function return ค่าเป็น Model รับค่า id category เข้ามา
    final response = await http.get(
      Uri.parse(baseAPIURL + 'wp/v2/posts?categories=$id&_embed'),
      headers: _setHeaders()
    );

    //เช็คว่ามีข้อมูลมาไหม ถ้ามีข้อมูลมา
    if(response.body.isNotEmpty){ //response.body เป็น ข้อมูลที่ดึงมาได้จาก api
      return newsModelFromJson(response.body); //จับค่าที่ได้จาก api ใส่เข้าไปใน model แล้ว return ออกไป
    }else{ //ถ้าไม่พบข้อมูล
      return null; //ส่ง null ออกไป
    }
  }

  //เขียน API รายละเอียดข่าว
  Future<NewsDetailModel?>  getNewsDetail(id) async { //Future function return ค่าเป็น Model รับค่า id ข่าวเข้ามา
    final response = await http.get(
      Uri.parse(baseAPIURL + 'wp/v2/posts/$id?_embed'),
      headers: _setHeaders()
    );

    //เช็คว่ามีข้อมูลมาไหม ถ้ามีข้อมูลมา
    if(response.body.isNotEmpty){ //response.body เป็น ข้อมูลที่ดึงมาได้จาก api
      return newsDetailModelFromJson(response.body); //จับค่าที่ได้จาก api ใส่เข้าไปใน model แล้ว return ออกไป
    }else{ //ถ้าไม่พบข้อมูล
      return null; //ส่ง null ออกไป
    }
  }

}