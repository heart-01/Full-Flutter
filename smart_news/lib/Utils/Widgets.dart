import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smart_news/Models/NewsModel.dart';

import 'Images.dart';
import 'constant.dart';

Widget placeHolderWidget(
{
    double? height,
    double? width,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    double? radius
  }
) 
{
return Image.asset(greyImage,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        alignment: alignment ?? Alignment.center)
    .cornerRadiusWithClipRRect(radius ?? defaultRadius);
}

Widget cachedImage(String url,
    {double? height,
    double? width,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    bool usePlaceholderIfUrlEmpty = true,
    double? radius}) {
  if (url.validate().isEmpty) {
    return placeHolderWidget(
        height: height,
        width: width,
        fit: fit,
        alignment: alignment,
        radius: radius);
  } else if (url.validate().startsWith('http')) {
    return CachedNetworkImage(
      imageUrl: url,
      height: height,
      width: width,
      fit: fit,
      alignment: alignment as Alignment? ?? Alignment.center,
      errorWidget: (_, s, d) {
        return placeHolderWidget(
            height: height,
            width: width,
            fit: fit,
            alignment: alignment,
            radius: radius);
      },
      placeholder: (_, s) {
        if (!usePlaceholderIfUrlEmpty) return SizedBox();
        return placeHolderWidget(
            height: height,
            width: width,
            fit: fit,
            alignment: alignment,
            radius: radius);
      },
    );
  } else {
    return Image.asset(url,
            height: height,
            width: width,
            fit: fit,
            alignment: alignment ?? Alignment.center)
        .cornerRadiusWithClipRRect(radius ?? defaultRadius);
  }
}

// สร้าง ListView สำหรับแสดงข่าว
Widget listViewNews(List<NewsModel> news) { //รับ parameter เป็น Model List ตั้งชื่อว่า news ไว้
  return ListView.builder(
    //ListView builder จะต้องการ popperty เป็น itemBuilder เป็นการวาง Widget เข้าไปใน Widget ListView.builder , itemCount เป็นการนับว่ามีกี่ชื้น กี่เรคคอด
    itemCount: news.length, //นับจำนวนว่ามีกี่เรคคอด
    shrinkWrap: true, //wrap ข้อมูลให้ listView คลุมข้อมูลทั้งหมดไว้เป็นก้อนเดียวกันเวลาเลื่อนเลื่อนขึ้นเลื่อนลงทั้งแถวเดียวกัน
    physics: NeverScrollableScrollPhysics(),//เลื่อนทับตัวอื่น ๆ ได้ด้วย เช่น เวลา content ยาว ๆ จะสามารถเลือนขวาไปดูเนื้อหานั้นได้แต่ NeverScrollableScrollPhysics คือ การปิดไม่สามารถเลื่อนได้ใช้ร่วมกับ shrinkWrap
    padding: EdgeInsets.all(8), //ระยะห่างของ listview
    scrollDirection: Axis.vertical, //ทิศทางในการเลื่อน vertical แนวตั้ง , horizontal แนวนอน
    itemBuilder: (context,index) { //ListView.builder จะมี index ลำดับที่แต่ละตัว

      //Load Model news ใส่ในตัวแปร Object newsModel
      NewsModel newsModel = news[index]; //news จะเป็นตัวแปร parameter ที่เก็บค่า Model ไว้เป็น list array เลยต้องเอา index มาใส่เพื่อแสดงข้อมูลตาม index array
      // inspect(newsModel);
      return  GestureDetector( // การกดปุ่มเหมือน a href
                onTap: () {
                  Navigator.pushNamed(context, '/newsdetail', arguments: { 'id': newsModel.id }); //เปิดหน้าใหม่แล้วส่งค่า id ไป
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  width: context.width(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Hero( //widget hero คือ animations ที่แสดงผลเหมือน Modal เวลาเปิดจะเด้งเปิดขึ้นมาแล้วเวลาปิดจะกลับลงไปที่เดิมตาม tag ที่กำหนดไว้
                        tag: newsModel.id!, //กำหนดให้ tag มีค่าตาม id เพราะ ห้ามซ้ำกับ tag ตัวอื่น ! ห้ามเป็นค่า null
                        child: cachedImage( //เก็บค่าแคชรูปภาพไว้เพื่อครั้งหน้าเวลาเป็นรูปภาพเดิมจะไม่โหลดใหม่
                                newsModel.embedded!.wpFeaturedmedia![0].sourceUrl.toString(), //ดึงรูปภาพมาแสดง
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover)
                            .cornerRadiusWithClipRRect(10)
                            .visible( //โหลดรูปภาพที่จะแสดงให้เห็น
                                newsModel.embedded!.wpFeaturedmedia![0].sourceUrl.toString().isNotEmpty, //ดึงรูปภาพมาแสดงห้ามเป็นค่าว่าง
                                defaultWidget: Image.asset(greyImage, //ถ้าโหลดรูปภาพไม่เสร็จจะแสดงเป็นรูปค่าที่ได้ตั้งไว้
                                fit: BoxFit.cover,
                                height: 150,
                                width: 150)
                                .cornerRadiusWithClipRRect(10)
                            ),
                      ),
                      8.width,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              parseHtmlString( newsModel.title!.rendered ), //ดึงข้อมูลตัวอักษรหัวข้อ
                              style: boldTextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .color,
                                  size: textSizeMedium),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            8.height,
                            Text(
                              parseHtmlString( newsModel.content!.rendered ),  //ดึงข้อมูลตัวอักษรเนื้อหา
                              style:
                                  secondaryTextStyle(size: textSizeSMedium),
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                            8.height,
                            Align(
                              child: Text(
                                  DateFormat.yMMMMd('en_US').format(
                                      DateTime.parse( newsModel.dateGmt.toString() )), //ดึงเวลามาแล้วใช้ packet จัด format date
                                  style: secondaryTextStyle(size: 11)),
                              alignment: Alignment.centerRight,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
    },
  );
  
}

String parseHtmlString(String? htmlString) { //function แปลง html to string
  return parse(parse(htmlString).body!.text).documentElement!.text;
}