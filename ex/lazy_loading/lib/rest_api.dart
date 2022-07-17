import 'package:http/http.dart' as http;
import 'package:lazy_loading/ImageModel.dart';

class CallApi {

  Future<ImageModel?> addNewImage() async 
  {    
    var response = await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
    //เช็คว่ามีข้อมูลมาไหม ถ้ามีข้อมูลมา
    if(response.body.isNotEmpty){ //response.body เป็น ข้อมูลที่ดึงมาได้จาก api
      return imageModelFromJson(response.body); //จับค่าที่ได้จาก api ใส่เข้าไปใน model แล้ว return ออกไป
    }else{ //ถ้าไม่พบข้อมูล
      return null; //ส่ง null ออกไป
    }
  }

}