import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale/models/NewsModel.dart';
import 'package:flutter_scale/services/rest_api.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(      // pull to refresh ดึงลงแล้วโหลดข้อมูลใหม่
      onRefresh: () async { // Event ของ pull to refresh จะ return เป็น Future ต้องใช้เป็น async function
        setState(() {
          if (kDebugMode) {
            print('pull to refresh');
          }
        });
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min, //ขนาดของตัว Column จะท่ากับ Content ใน Column
          crossAxisAlignment: CrossAxisAlignment.start, // เรียงเนื้องหาใน Column จาก ซ้ายไปขวา
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('ข่าวประกาศล่าสุด', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
            ),
    
            //ListView ไว้สำหรับแสดงข่าว 5 ข่าวล่าสุด
            SizedBox(
              height: 210.0,
              child: FutureBuilder
              (  
                future: CallAPI().getLastNews(), 
                builder: (BuildContext context, AsyncSnapshot snapshot)
                {
                  if(snapshot.hasError) // ถ้าโหลดข้อมูลไม่ได้ หรือมีข้อผิดพลาด
                  {
                    return const Center(child: Text('มีข้อผิดพลาดในการโหลดข้อมูล'));
                  }else if(snapshot.connectionState == ConnectionState.done) // ถ้าโหลดข้อมูลสำเร็จ
                  { 
                    List<NewsModel>? news = snapshot.data;
                    return _listViewLastNews(news!);
                  }else{  // ระหว่างที่กำหลังโหลดข้อมูล สามารถใส่ loading...
                    return const Center( child: CircularProgressIndicator());
                  }
                }
              ),
            ),
    
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('ข่าวประกาศทั้งหมด', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
            ),
    
            //ListView ไว้สำหรับแสดงข่าวทั้งหมด
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: FutureBuilder
              (  
                future: CallAPI().getAllNews(), 
                builder: (BuildContext context, AsyncSnapshot snapshot)
                {
                  if(snapshot.hasError)  // ถ้าโหลดข้อมูลไม่ได้ หรือมีข้อผิดพลาด
                  {
                    return const Center(child: Text('มีข้อผิดพลาดในการโหลดข้อมูล'));
                  }else if(snapshot.connectionState == ConnectionState.done) // ถ้าโหลดข้อมูลสำเร็จ
                  { 
                    List<NewsModel>? news = snapshot.data;
                    return _listViewAllNews(news!);
                  }else{  // ระหว่างที่กำหลังโหลดข้อมูล สามารถใส่ loading...
                    return const Center( child: CircularProgressIndicator());
                  }
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  //----------------------------------
  // สร้าง ListView สำหรับการแสดงข่าวทั้งหมด
  //----------------------------------
  Widget _listViewAllNews(List<NewsModel> news) { // function รับค่าจาก news api มาแปลงใส่ model
    return ListView.builder(  // ListView builder ชนิดไดนามิก ใช้กับ API
      // physics: const NeverScrollableScrollPhysics(), // physics จะกำหนดให้ผู้ใช้งานเลื่อนได้ภายในกรอบไม่กะทบออกไปด้านนอก
      shrinkWrap: true, // Wrap ListView ให้อยู่ในกรอบที่กำหนด
      scrollDirection: Axis.vertical, // Listview เลื่อนแนวตั้ง
      itemCount: news.length, // ขนาดของ item ใน ListView
      // itemBuilder จะเป็นการ loop ListView พร้อมกับบอก index
      itemBuilder: (context, index){
        // Load Model
        NewsModel newsModel = news[index]; // นำ Model มาเป็น Object
        
        // ออกแบบส่วนหน้าตาของการแสดงผล listview
        return ListTile(  // นำข้อมูลจาก Object Model มาใส่ใน ListTile
          leading: const Icon(Icons.pages),
          title: Text(newsModel.topic, overflow: TextOverflow.ellipsis), // TextOverflow จะตัดคำเองเมื่อเกินหน้าจอ
          subtitle: Text(newsModel.detail, overflow: TextOverflow.ellipsis),
          onTap: (){
            Navigator.pushNamed(
              context, 
              '/newsdetail', 
              arguments: {'id': newsModel.id}
            );
            if (kDebugMode) {
              print(newsModel.id);
            }
          },
        );
      },
    );
  }

  //----------------------------------
  // สร้าง ListView สำหรับการแสดงข่าวล่าสุด
  //----------------------------------
  Widget _listViewLastNews(List<NewsModel> news) {
    return ListView.builder(
        physics: const ClampingScrollPhysics(), // Scroll เฉพาะใน ListView นี้เท่านั้นไม่กระทบกับ Widget จุดอื่น
        shrinkWrap: true, // Wrap ListView ให้อยู่ในกรอบที่กำหนด
        scrollDirection: Axis.horizontal, // Listview เลื่อนแนวนอน
        itemCount: news.length, // ขนาดของ item ใน ListView
        // itemBuilder จะเป็นการ loop ListView พร้อมกับบอก index
        itemBuilder: (context, index) {
          // Load Model
          NewsModel newsModel = news[index];
          // ออกแบบส่วนหน้าตาของการแสดงผล listview
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.60,
            child: InkWell(
              onTap: () {
                // เปิดหน้า news detail พร้อมแนบตัวแปร id ไปอีกหน้า
                Navigator.pushNamed(
                  context,
                  '/newsdetail', 
                  arguments: {'id': newsModel.id}
                );
              },
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 125.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(newsModel.imageurl),
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            newsModel.topic,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            newsModel.detail,
                            style: const TextStyle(fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
    );
  }
}
