// ignore_for_file: unnecessary_new

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale/models/ProductsModel.dart';
import 'package:flutter_scale/services/rest_api.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final formKey = GlobalKey<FormState>();

  late String? productName,
      productDetail,
      productBarcode,
      productPrice,
      productQty,
      productImage;

  Widget productNameText() {
    return TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      style: const TextStyle(fontSize: 20, color: Colors.black),
      decoration: const InputDecoration(
          hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
          labelText: 'ชื่อสินค้า',
          labelStyle: TextStyle(color: Colors.teal, fontSize: 20),
          errorStyle: TextStyle(fontSize: 16.0)),
      validator: (value) {
        if (value!.isEmpty) {
          return "* จำเป็น";
        } else {
          return null;
        }
      },
      onSaved: (value) {
        productName = value;
      },
    );
  }

  Widget productDetailText() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      autofocus: false,
      style: const TextStyle(fontSize: 20, color: Colors.black),
      decoration: const InputDecoration(
          hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
          labelText: 'รายละเอียด',
          labelStyle: TextStyle(color: Colors.teal, fontSize: 20),
          errorStyle: TextStyle(fontSize: 16.0)),
      validator: (value) {
        if (value!.isEmpty) {
          return "* จำเป็น";
        } else {
          return null;
        }
      },
      onSaved: (value) {
        productDetail = value;
      },
    );
  }

  Widget productBarcodeText() {
    return TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      style: const TextStyle(fontSize: 20, color: Colors.black),
      decoration: const InputDecoration(
          hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
          labelText: 'บาร์โค้ด',
          labelStyle: TextStyle(color: Colors.teal, fontSize: 20),
          errorStyle: TextStyle(fontSize: 16.0)),
      validator: (value) {
        if (value!.isEmpty) {
          return "* จำเป็น";
        } else {
          return null;
        }
      },
      onSaved: (value) {
        productBarcode = value;
      },
    );
  }

  Widget productQtyText() {
    return TextFormField(
      keyboardType: TextInputType.number,
      autofocus: false,
      style: const TextStyle(fontSize: 20, color: Colors.black),
      decoration: const InputDecoration(
          hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
          labelText: 'จำนวน',
          labelStyle: TextStyle(color: Colors.teal, fontSize: 20),
          errorStyle: TextStyle(fontSize: 16.0)),
      validator: (value) {
        if (value!.isEmpty) {
          return "* จำเป็น";
        } else {
          return null;
        }
      },
      onSaved: (value) {
        productQty = value;
      },
    );
  }

  Widget productPriceText() {
    return TextFormField(
      keyboardType: TextInputType.number,
      autofocus: false,
      style: const TextStyle(fontSize: 20, color: Colors.black),
      decoration: const InputDecoration(
          hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
          labelText: 'ราคา',
          labelStyle: TextStyle(color: Colors.teal, fontSize: 20),
          errorStyle: TextStyle(fontSize: 16.0)),
      validator: (value) {
        if (value!.isEmpty) {
          return "* จำเป็น";
        } else {
          return null;
        }
      },
      onSaved: (value) {
        productPrice = value;
      },
    );
  }

  Widget productImageText() {
    return TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      style: const TextStyle(fontSize: 20, color: Colors.black),
      decoration: const InputDecoration(
          hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
          labelText: 'รูปภาพสินค้า',
          labelStyle: TextStyle(color: Colors.teal, fontSize: 20),
          errorStyle: TextStyle(fontSize: 16.0)),
      validator: (value) {
        if (value!.isEmpty) {
          return "* จำเป็น";
        } else {
          return null;
        }
      },
      onSaved: (value) {
        productImage = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: productNameText(),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: productDetailText(),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: productBarcodeText(),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: productPriceText(),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: productQtyText(),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: productImageText(),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 5, left: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      ProductsModel productdata = new ProductsModel(
                        // นำข้อมูล Map data เข้าไปที่ Model Products
                        productName: productName.toString(),
                        productDetail: productDetail.toString(),
                        productBarcode: productBarcode.toString(),
                        productImage: productImage.toString(),
                        productPrice: productPrice.toString(),
                        productQty: productQty.toString(),
                      );

                      // print(productdata);
                      inspect(productdata);  // Debug Map data to Model Product

                      var response = await CallAPI().createProduct(productdata); // call api create productdata

                      if(response == true) {
                        Navigator.pop(context, true); // ปิดหน้า addProduct    
                      }else{
                        if (kDebugMode) {
                          print(response);
                        }
                      }

                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'บันทึกข้อมูล',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
