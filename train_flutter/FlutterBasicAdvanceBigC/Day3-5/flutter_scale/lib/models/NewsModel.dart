/*
แยกข้อมูลทำเป็น Model
คนที่มาทำงานต่อก็สามารถรู้ได้ถึงโครงสร้างข้อมูลได้ทันทีหลังจากดู Model
การที่เราทำงานกับ JSON นั้นมันจะสร้างความลำบากให้เราได้ถ้าเราเอาสิ่งที่ได้จาก jsonDecode 
มาใช้โดยตรง เพราะ ตัว IDE หรือ Editor ที่เราใช้ มันจะไม่บอกว่าตัวแปรของเรามีสมาชิกอะไรบ้าง
เราจึงจะทำการสร้าง class เพื่อที่จะมาจัดการกับข้อมูล แทนที่จะไปใช้ Map โดยตรง
*/

import 'dart:convert';

List<NewsModel> newsModelFromJson(String str) =>
    List<NewsModel>.from(json.decode(str).map((x) => NewsModel.fromJson(x)));

String newsModelToJson(List<NewsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsModel {
  NewsModel({
    required this.id,
    required this.topic,
    required this.detail,
    required this.imageurl,
    required this.linkurl,
    required this.createdAt,
    required this.status,
  });

  String id;
  String topic;
  String detail;
  String imageurl;
  String linkurl;
  DateTime? createdAt;
  String status;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        id: json["id"] ?? null,
        topic: json["topic"] ?? null,
        detail: json["detail"] ?? null,
        imageurl: json["imageurl"] ?? null,
        linkurl: json["linkurl"] ?? null,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        status: json["status"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? null,
        "topic": topic ?? null,
        "detail": detail ?? null,
        "imageurl": imageurl,
        "linkurl": linkurl ?? null,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "status": status ?? null,
      };
}
