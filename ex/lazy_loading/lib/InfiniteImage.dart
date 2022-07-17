import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:lazy_loading/ImageModel.dart';
import 'package:lazy_loading/rest_api.dart';
import 'package:http/http.dart' as http;

class InfiniteImage extends StatefulWidget {
  @override
  _InfiniteImageState createState() => _InfiniteImageState();
}

class _InfiniteImageState extends State<InfiniteImage> {

  List images = [];
  ImageModel? imageModel;

  void readImage() async {
    try { //try catch ไว้เช็คข้อผิดพลาด
      var response = await CallApi().addNewImage(); //CallApi แล้วเก็บใส่ตัวแปร response
      //อ่านค่าจาก API เสร็จดึงค่าลง Model 
      setState(() {
        imageModel = response; //อ่านค่าจาก API เสร็จดึงค่า response ลง newsDetailModel 
        String imageLocation = imageModel!.message!;
        // print(Image.network(imageLocation));
        images.add(imageLocation);
      });
    }catch(error){
      print(error);
    }
  }

  void readImage2() async {
    var response = await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
    Map res = jsonDecode(response.body);
    String imageLocation = res['message'];
    setState(() {
      images.add(imageLocation);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Infinite Scrolling Images'),
      ),
      body: LazyLoadScrollView(
        scrollOffset: 300,
        onEndOfPage: () => readImage(),
        child: listViewImage(images),        
      ),
    );
  }

  Widget listViewImage(image) {
    return ListView.builder(
      itemCount: image.length,
      itemBuilder: (context, index) {
        // print('-----------------');
        // print(image.elementAt(index));
        // return Image.network(image.elementAt(index));

        return  GestureDetector( // การกดปุ่มเหมือน a href
          onTap: () {
            print('Click');
          },
          child: CachedNetworkImage(
            imageUrl: image.elementAt(index),
            imageBuilder: (context, imageProvider) => Container( //ตกแต่งรูป
              width: 100,
              height: 200,
              margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider, 
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.black,
                  width: 8,
                ),
              ),
            ),
            placeholder: (context, url) => Container( //รูปตอนโหลดข้อมูล
              child: Padding(
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
                            color: Color(0xFF3949ab),
                            value: 1.0,
                          ),
                        ),
                      ),
                      Center(child: Text("กำลังโหลด...")),
                    ],
                  ),
                ),
              ),
            ),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
        );

      }
    );
  }
  
}
