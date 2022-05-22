import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale/models/NewsModel.dart';
import 'package:flutter_scale/services/rest_api.dart';
import 'package:flutter_scale/utils/constants.dart' as constants;

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min, //ขนาดของตัว Column จะท่ากับ Content ใน Column
        crossAxisAlignment: CrossAxisAlignment.start, // เรียงเนื้องหาใน Column จาก ซ้ายไปขวา
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('ข่าวประกาศล่าสุด', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
          ),

          const SizedBox( height: 200, ),

          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('ข่าวประกาศทั้งหมด', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
          ),

          //ListView ไว้สำหรับแสดงข่าว
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: FutureBuilder
            (  
              future: CallAPI().getAllNews(), 
              builder: (BuildContext context, AsyncSnapshot snapshot)
              {
                if(snapshot.hasError)
                {
                  return const Center(child: Text('มีข้อผิดพลาดในการโหลดข้อมูล'));
                }else if(snapshot.connectionState == ConnectionState.done)
                { 
                  List<NewsModel>? news = snapshot.data;
                  return _listViewAllNews(news!);
                }else{ 
                  return const Center( child: CircularProgressIndicator());
                }
              }
            ),
          ),
        ],
      ),
    );
  }

  Widget _listViewAllNews(List<NewsModel> news) { // function รับค่าจาก news api มาแปลงใส่ model
    return ListView.builder(  // ListView builder ชนิดไดนามิก ใช้กับ API
      // physics: const NeverScrollableScrollPhysics(), // physics จะกำหนดให้ผู้ใช้งานเลื่อนได้ภายในกรอบไม่กะทบออกไปด้านนอก
      shrinkWrap: true, // Wrap ListView ให้อยู่ในกรอบที่กำหนด
      scrollDirection: Axis.vertical,
      // scrollDirection: Axis.horizontal,
      itemCount: news.length,
      // itemBuilder จะเป็นการ loop พร้อมกับบอก index
      itemBuilder: (context, index){
        // Load Model
        NewsModel newsModel = news[index]; // นำ Model มาเป็น Object
        
        return ListTile(  // นำข้อมูลจาก Object Model มาใส่ใน ListTile
          leading: const Icon(Icons.pages),
          title: Text(newsModel.topic, overflow: TextOverflow.ellipsis), // TextOverflow จะตัดคำเองเมื่อเกินหน้าจอ
          subtitle: Text(newsModel.detail, overflow: TextOverflow.ellipsis),
          onTap: (){
            if (kDebugMode) {
              print(newsModel.id);
            }
          },
        );
      },
    );
  }
}
