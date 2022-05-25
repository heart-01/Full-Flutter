// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter_scale/models/NewsDetailModel.dart';
import 'package:flutter_scale/models/NewsModel.dart';
import 'package:flutter_scale/models/ProductsModel.dart';
import 'package:flutter_scale/models/UserModel.dart';
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

  //Future คือ  รูปแบบการีเทิร์นข้อมูลที่มีการรอคอยว่าข้อมูลที่ตอบกลับมาคืออะไร
  //ด้านใน <> คือ class model พอได้ข้อมูลจาก Future กลับแล้วเราก็จะโยนใส่กล่อง model
  //ใน model จะมีการ return ค่ากลับมาเป็นแบบ List เราต้องใส่ type ให้ด้วย แล้วเอาข้อมูลใน list กับไปวน loop ออกมา
  //ข้อมูลใน List model อาจจะไม่มีข้อมูลก็ได้เราต้องใส่ ? ให้ด้วย

  //API อ่านข่าวลทั้งหมด
  Future<List<NewsModel>?>  getAllNews() async { //Future function return ค่าเป็น Model
    var response = await http.get(
      Uri.parse(constant.baseAPIURL + 'news'), 
      headers: _setHeaders(),
    );

    //จับค่าที่ได้จาก api ใส่เข้าไปใน class model method newsModelFromJson แล้ว return ออกไป
    return (response.body != null) ? newsModelFromJson(response.body) : null ;
  }

  // อ่านข่าวล่าสุด
  Future<List<NewsModel>?> getLastNews() async {
    var response = await http.get(
      Uri.parse(constant.baseAPIURL+'lastnews'),
      headers: _setHeaders(),
    );
    return (response.body != null) ? newsModelFromJson(response.body) : null ;
  }

  // อ่านรายละเอียดข่าวตาม id จะ return แค่่ 1 data ไม่ return List array หรือ return null
  Future<NewsDetailModel?> getNewsByID(id) async {
    var response = await http.get(
      Uri.parse(constant.baseAPIURL+'news/'+id),
      headers: _setHeaders(),
    );
    return (response.body != null) ? newsDetailModelFromJson(response.body) : null ;
  }

  // แสดงโปรไฟล์ของ user จะ return แค่่ 1 data ไม่ return List array หรือ return null
  Future<UserModel?> getProfile(id) async {
    var response = await http.get(
      Uri.parse(constant.baseAPIURL+'users/'+id),
      headers: _setHeaders(),
    );
    return (response.body != null) ? userModelFromJson(response.body) : null ;
  }

  // แสดงสินค้า return 
  Future<List<ProductsModel>?> getProducts() async {
    var response = await http.get(
      Uri.parse(constant.baseAPIURL+'products'),
      headers: _setHeaders(),
    );
    return (response.body != null) ? productsModelFromJson(response.body) : null ;
  }

  // Add New Product รับค่าเป็น List array data model ที่ถูกส่งเข้ามา return bool
  Future<bool> createProduct(ProductsModel data) async {
    final response = await http.post(
      Uri.parse(constant.baseAPIURL+'products'),
      headers: _setHeaders(),
      body: productModelToJson(data),
    );

    if(response.statusCode == 200){ // เช็ค status code เมื่อส่งค่าให้ api
      return true;
    }else{
      return false;
    }
  }

  // Update Product รับค่าเป็น List array data model ที่ถูกส่งเข้ามา return bool
  Future<bool> updateProduct(ProductsModel data) async {
    final response = await http.put(
      Uri.parse(constant.baseAPIURL+'products/${data.id}'),
      headers: _setHeaders(),
      body: productModelToJson(data),
    );

    return (response.statusCode == 200) ? true :false;
  }

  // Delete Product
  Future<bool> deleteProduct(String id) async {
    final response = await http.delete(
      Uri.parse(constant.baseAPIURL+"products/$id"),
      headers: _setHeaders(),
    );

    return (response.statusCode == 200) ? true :false;
  }

}