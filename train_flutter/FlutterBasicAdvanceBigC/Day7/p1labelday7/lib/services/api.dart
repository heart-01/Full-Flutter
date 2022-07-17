import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:p1label/models/PrductsModel.dart';

class CallAPI {

  // สร้าง method read json products
  Future<List> readProduct(barcode) async {
    final resonse = await rootBundle.loadString('assets/data/products.json');
    final data = await json.decode(resonse);
    return data;
  }

  // อ่านข้อมูลสินค้า
  Future<List<ProductsModel>> getAllProduct() async {
    final resonse = await rootBundle.loadString('assets/data/products.json');
    var list = await json.decode(resonse).cast<Map<String, dynamic>>();
    return await list.map<ProductsModel>((json)=> ProductsModel.fromJson(json)).toList(); // ส่งตัวแปร list ไป map กับ ProductModel แล้วแปลงเป็น List
  }

}