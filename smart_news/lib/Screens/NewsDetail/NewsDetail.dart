import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smart_news/Models/NewsDetailModel.dart';
import 'package:smart_news/Network/rest_api.dart';
import 'package:smart_news/Themes/colors.dart';
import 'package:smart_news/Utils/Widgets.dart';
import 'package:smart_news/Utils/constant.dart';

class NewsDetail extends StatefulWidget {

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {

  //เรียกใช้งาน load Model เหมือนเป็นกล่องเปล่า ๆ  
  NewsDetailModel? newsDetailModel; //newsDetailModel เป็นตัวแปรแบบ Object ใช้ได้ทุกอย่างของ Class

  //สร้างฟังก์ชั่นอ่านรายละเอียดข่าวรับค่า id ได้
  readNewsDetail(id) async {
    try { //try catch ไว้เช็คข้อผิดพลาด
      var response = await CallApi().getNewsDetail(id); //CallApi แล้วเก็บใส่ตัวแปร response
      //อ่านค่าจาก API เสร็จดึงค่าลง Model 
      setState(() {
        newsDetailModel = response; //อ่านค่าจาก API เสร็จดึงค่า response ลง newsDetailModel 
      });

    }catch(error){
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    //เขียนรับค่าผ่าน initState
    final widgetsBinding = WidgetsBinding.instance;

    widgetsBinding!.addPostFrameCallback((callback) {
      // การรับค่าจาก arguments
      if (ModalRoute.of(context)!.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
        // เรียกฟังก์ชัน readNewsDetail
        print(readNewsDetail(arguments['id'].toString()));
      }
    });

  }

  @override
  Widget build(BuildContext context) {

    //ควรเขียนรับค่าไว้ตรงนี้เพราะเวลา build widget สำเร็จแล้วเราควรจำได้ id มา ถ้าเขียนไว้ข้างนอกอาจจะไม่ได้ค่าทุกครั้ง
    //การรับค่าจาก arguments
    // final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    //เรียกใช้งาน id ทดสอบการแสดงผล arguments ที่ได้มา
    // print(arguments['id'].toString());
    
    //ทดสอบเรียกใช้ function readNewsDetail
    // inspect(readNewsDetail(arguments['id'].toString()));

    //เรียก function readNewsDetail
    // readNewsDetail(arguments['id'].toString());
    
    return Scaffold(
      body: newsDetailModel != null ? NestedScrollView( //เช็คว่า newsDetailModel ไม่ใช่ null ให้โหลด NestedScrollView มา ให้เลื่อนขึ้นลงได้
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: context.height() * 0.55,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: newsDetailModel!.id!, 
                  child: cachedImage(newsDetailModel!.embedded!.wpFeaturedmedia![0].sourceUrl.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
                collapseMode: CollapseMode.parallax,
                title: newsDetailModel != null ?
                Text(
                  parseHtmlString(newsDetailModel!.title!.rendered),
                  style: boldTextStyle(size: textSizeNormal, color: Theme.of(context).textTheme.headline6!.color),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ).visible(innerBoxIsScrolled).paddingOnly(left: isIos ? 16 : 0) : SizedBox(),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              leading: BackButton(
                color: Colors.black,
                onPressed: () async {
                  finish(context);
                },
              ),
            )
          ];
        },
        body: newsDetailModel != null ?
        Container(
          color: Theme.of(context).cardTheme.color,
          height: context.height(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.height,
                  Text(
                    '${parseHtmlString(newsDetailModel!.title!.rendered)}',
                    style: boldTextStyle(
                      size: textSizeLarge,
                      color: Theme.of(context).textTheme.headline6!.color,
                    ),
                    maxLines: 5,
                  ),
                  8.height,
                  Text(
                    '${'Author By ${parseHtmlString(newsDetailModel!.embedded!.author![0].name)}'}',
                    style: primaryTextStyle(color: Colors.blue, size: 14),
                  ).visible(newsDetailModel!.embedded!.author![0].name!.isNotEmpty),
                  10.height,
                  
                  Html(data: newsDetailModel!.content!.rendered),
                  
                ],
              ),
            ),
          ),
        ): Padding(
          padding: const EdgeInsets.only(top:250.0),
          child: SizedBox(
            height: 200.0,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    child: new CircularProgressIndicator(
                      strokeWidth: 1,
                      color: primaryColor,
                      value: 1.0,
                    ),
                  ),
                ),
                Center(child: Text("กำลังโหลด...")),
              ],
            ),
          ),
        ),
      ) : Padding( //ถ้าเป็น null ให้แสดงรูปการโหลด
          padding: const EdgeInsets.only(top:250.0),
          child: SizedBox(
            height: 200.0,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    child: new CircularProgressIndicator(
                      strokeWidth: 1,
                      color: primaryColor,
                      value: 1.0,
                    ),
                  ),
                ),
                Center(child: Text("กำลังโหลด...")),
              ],
            ),
          ),
      ),
    );

  }

  String parseHtmlString(String? htmlString) {
    return parse(parse(htmlString).body!.text).documentElement!.text;
  }
  
}