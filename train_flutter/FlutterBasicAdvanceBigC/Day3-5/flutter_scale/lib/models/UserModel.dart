/*
แยกข้อมูลทำเป็น Model
คนที่มาทำงานต่อก็สามารถรู้ได้ถึงโครงสร้างข้อมูลได้ทันทีหลังจากดู Model
การที่เราทำงานกับ JSON นั้นมันจะสร้างความลำบากให้เราได้ถ้าเราเอาสิ่งที่ได้จาก jsonDecode 
มาใช้โดยตรง เพราะ ตัว IDE หรือ Editor ที่เราใช้ มันจะไม่บอกว่าตัวแปรของเรามีสมาชิกอะไรบ้าง
เราจึงจะทำการสร้าง class เพื่อที่จะมาจัดการกับข้อมูล แทนที่จะไปใช้ Map โดยตรง
*/
// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        required this.id,
        required this.username,
        required this.password,
        required this.fullname,
        required this.imgProfile,
        required this.status,
    });

    String id;
    String username;
    String password;
    String fullname;
    String imgProfile;
    String status;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] ?? null,
        username: json["username"] ?? null,
        password: json["password"] ?? null,
        fullname: json["fullname"] ?? null,
        imgProfile: json["img_profile"] ?? null,
        status: json["status"] ?? null,
    );

    Map<String, dynamic> toJson() => {
        "id": id ?? null,
        "username": username ?? null,
        "password": password ?? null,
        "fullname": fullname ?? null,
        "img_profile": imgProfile ?? null,
        "status": status ?? null,
    };
}