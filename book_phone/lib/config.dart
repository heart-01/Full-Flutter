import 'dart:io';
import 'package:http/http.dart' as http;

class Connect {
  String url = "http://192.168.211.1:3000/";  //เก็บ url ที่เป็นหลักในการ call api ใน emulater จะไม่รู้จัก localhost เลยต้องเปลี่ยนมา set แบบ ip address พอร์ต 3000 เป็นของ api node js express
  var header = { HttpHeaders.contentTypeHeader: "application/json" }; //set ว่า เป็น content ชนิด json

  Future<http.Response> postData(path, data) async { //Future ก็คือ thead function ทำงานแบบ async ชื่อ postData จะรับ parameter 2 ตัวคือ path กับ data จะ return Response ออกมา 
    return http.post(Uri.parse(url + path), headers: header, body: data); //
  } 

  Future<http.Response> gatData(path) async {
    return http.get(Uri.parse(url + path), headers: header); // Future function getData
  } 

  Future<http.Response> delData(path) async {
    return http.delete(Uri.parse(url + path), headers: header); // Future function delData
  } 

  Future<http.Response> editData(path, data) async {
    return http.put(Uri.parse(url + path), headers: header, body: data); // Future function editData
  } 

  Future<http.Response> search(path) async {
    return http.get(Uri.parse(url + path), headers: header);
  }

  Future<http.Response> delFile(path) async {
    return http.delete(Uri.parse(url + path), headers: header);
  } 

}