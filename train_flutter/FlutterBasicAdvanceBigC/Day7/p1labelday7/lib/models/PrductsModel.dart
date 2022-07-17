// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

List<ProductsModel> productsModelFromJson(String str) => List<ProductsModel>.from(json.decode(str).map((x) => ProductsModel.fromJson(x)));

String productsModelToJson(List<ProductsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductsModel {
    ProductsModel({
        required this.barcode,
        required this.rootcode,
        required this.pname,
        required this.md,
        required this.type,
        required this.status,
        required this.pog,
        required this.ot,
        required this.sp,
        required this.np,
        required this.boh,
        required this.bod,
        required this.pz,
        required this.p1,
        required this.sf,
        required this.bS,
    });

    String barcode;
    String rootcode;
    String pname;
    String md;
    String type;
    String status;
    String pog;
    String ot;
    String sp;
    String np;
    String boh;
    String bod;
    String pz;
    String p1;
    String sf;
    String bS;

    factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        barcode: json["barcode"] ?? null,
        rootcode: json["rootcode"] ?? null,
        pname: json["pname"] ?? null,
        md: json["md"] ?? null,
        type: json["type"] ?? null,
        status: json["status"] ?? null,
        pog: json["pog"] ?? null,
        ot: json["ot"] ?? null,
        sp: json["sp"] ?? null,
        np: json["np"] ?? null,
        boh: json["boh"] ?? null,
        bod: json["bod"] ?? null,
        pz: json["pz"] ?? null,
        p1: json["p1"] ?? null,
        sf: json["sf"] ?? null,
        bS: json["b_s"] ?? null,
    );

    Map<String, dynamic> toJson() => {
        "barcode": barcode ?? null,
        "rootcode": rootcode ?? null,
        "pname": pname ?? null,
        "md": md ?? null,
        "type": type ?? null,
        "status": status ?? null,
        "pog": pog ?? null,
        "ot": ot ?? null,
        "sp": sp ?? null,
        "np": np ?? null,
        "boh": boh ?? null,
        "bod": bod ?? null,
        "pz": pz ?? null,
        "p1": p1 ?? null,
        "sf": sf ?? null,
        "b_s": bS ?? null,
    };
}
