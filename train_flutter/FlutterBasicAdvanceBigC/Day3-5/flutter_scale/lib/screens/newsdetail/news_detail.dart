import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale/models/NewsDetailModel.dart';
import 'package:flutter_scale/services/rest_api.dart';

class NewsDetailScreen extends StatefulWidget {
  const NewsDetailScreen({ Key? key }) : super(key: key);

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {

  // สร้าง object _dataNews จาก Class NewsDetailModel 
  NewsDetailModel? _dataNews;

  // function อ่านข่าวตาม id ที่ถูกส่งมาจากหน้า NewsScreen
  readNewsDetail(id) async {
    // Call API
    try {
      var response = await CallAPI().getNewsByID(id);
      setState(() { // render ui ใหม่
        _dataNews = response; // นำค่า response มาใส่ใน dataNews
      });
    } catch(error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    // การรับค่าต้องรับผ่านตัว context เลยต้องมารับในจุดนี้
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    if (kDebugMode) {
      print(arguments['id']); // id ที่ถูกส่งมาจากหน้า NewsScreen
    } 

    // เรียกใช้งาน function readNewsDetail(id)
    readNewsDetail(arguments['id'].toString()); // parameter ที่ถูกส่งเข้า function เราต้องแปลงให้เป็น string

    return Scaffold(
      appBar: AppBar(
        title: Text(_dataNews?.topic ?? "..."),
      ),
      body: ListView(
        children: [
          Container( // รูปภาพ News Images
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(_dataNews?.imageurl ?? "..."),
                fit: BoxFit.cover,
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _dataNews?.topic ?? "...",
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _dataNews?.detail ?? "...",
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Published Date: ${_dataNews?.createdAt.toString() ?? "..."}',
              style: const TextStyle(fontSize: 16.0),
            ),
          )
        ],
      )
    );
  }
}