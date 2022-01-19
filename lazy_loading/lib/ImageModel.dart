import 'dart:convert';

ImageModel imageModelFromJson(String str) => ImageModel.fromJson(json.decode(str));

String imageModelToJson(ImageModel data) => json.encode(data.toJson());

class ImageModel {
    ImageModel({
        this.message,
        this.status,
    });

    String? message;
    String? status;

    factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        message: json["message"] == null ? null : json["message"],
        status: json["status"] == null ? null : json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "status": status == null ? null : status,
    };
}
