// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

List<ProductsModel> productsModelFromJson(String str) => List<ProductsModel>.from(json.decode(str).map((x) => ProductsModel.fromJson(x)));

String productModelToJson(ProductsModel data) => json.encode(data.toJson()); // รับข้อมูลเข้าที่ Model ต้องแก้จุดนี้ให้รับค่าแบบ Json data

class ProductsModel {
    ProductsModel({
        this.id,
        required this.productDetail,
        required this.productName,
        required this.productBarcode,
        required this.productQty,
        required this.productPrice,
        this.productDate,
        required this.productImage,
        this.productCategory,
        this.productStatus,
    });

    String? id;
    String productDetail;
    String productName;
    String productBarcode;
    String productQty;
    String productPrice;
    DateTime? productDate;
    String productImage;
    String? productCategory;
    String? productStatus;

    factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        id: json["id"] ?? null,
        productDetail: json["product_detail"] ?? null,
        productName: json["product_name"] ?? null,
        productBarcode: json["product_barcode"] ?? null,
        productQty: json["product_qty"] ?? null,
        productPrice: json["product_price"] ?? null,
        productDate: json["product_date"] == null ? null : DateTime.parse(json["product_date"]),
        productImage: json["product_image"] ?? null,
        productCategory: json["product_category"] ?? null,
        productStatus: json["product_status"] ?? null,
    );

    Map<String, dynamic> toJson() => {
        "id": id ?? null,
        "product_detail": productDetail ?? null,
        "product_name": productName ?? null,
        "product_barcode": productBarcode ?? null,
        "product_qty": productQty ?? null,
        "product_price": productPrice ?? null,
        "product_date": productDate == null ? null : "${productDate!.year.toString().padLeft(4, '0')}-${productDate!.month.toString().padLeft(2, '0')}-${productDate!.day.toString().padLeft(2, '0')}",
        "product_image": productImage ?? null,
        "product_category": productCategory ?? null,
        "product_status": productStatus ?? null,
    };
}
