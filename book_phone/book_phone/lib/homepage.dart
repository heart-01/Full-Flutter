import 'dart:convert';

import 'package:book_phone/config.dart';
import 'package:book_phone/service/mydetail.dart';
import 'package:book_phone/service/mylist.dart';
import 'package:book_phone/service/mywidget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage(
      {Key?
          key}) //Constructor Null Safety ใส่เครื่องหมาย ? เพื่อบอกให้รู้ว่าตัวแปรนั้นเป็น Nullable
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<
      ScaffoldState>(); //ผูกคีย์เพื่อจะจับ state การกระทำ ของ scaffold นี้

  //Future function getData
  List data = [];
  Future<void> getData() async {
    await Connect().gatData('get_All').then((value) {
      if (value.statusCode == 200) {
        setState(() {
          data = jsonDecode(value.body);
          print(data.length);
        });
      }
    });
  }

  //Future funciton deleteData
  Future<void> delete(int id, String avatar) async {
    await Connect().delData('delete_book/' + id.toString()).then((delBook) {
      Connect().delFile('remove/photos/' + avatar).then((delImg) { //API Delete Photo
        if (delBook.statusCode == 200 && delImg.statusCode == 200) {
          _scaffoldKey.currentState!.showSnackBar(
            SnackBar(
              content: Text("บันทึกสำเร็จ"),
            ),
          );
          Navigator.pop(context);
          getData();
        }
      });
    });
  }

  //Future function search
  TextEditingController _keyword =
      TextEditingController(); //ผูกคีย์เพื่อจะจับ Event การกระทำ ของ textbox
  Future<void> search() async {
    await Connect().search('Search_book/' + _keyword.text).then((value) {
      if (value.statusCode == 200) {
        setState(() {
          data = jsonDecode(value.body);
          print(data.length);
        });
      }
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('รายชื่อ'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                //เปิดหน้าใหม่เพิ่มเข้ามา
                context, //context เหมือนเป็นท่อลำเลียงส่ง widget ไปอีกหน้าหนึ่ง
                MaterialPageRoute(
                  //แสดงหน้าใหม่เพิ่มเข้ามาตาม route
                  builder: (context) => Mydetail(
                    //ส่ง context ไปทำงานที่หน้า Mydetail
                    text: "add", //ส่งข้อมูล text ชื่อ add แนบไปด้วย
                  ),
                ),
              ).then((value) {
                //เมื่อย้อนกลับมาหน้าเดิม ค่า value จะได้จากการกลับมาหน้าเดิมแล้วมีตัวแปรแนบมาด้วย
                // print(value);
                if (value ?? false) {
                  //เช็คตัวแปร value ที่เข้ามาถ้าเป็น null จะบังคับให้ทำข้างหลังคือ false จะไม่ทำงาน ถ้ามีค่าไม่ใช่ null จะทำงาน
                  _scaffoldKey.currentState!.showSnackBar(
                    SnackBar(
                      content: Text("บันทึกสำเร็จ"),
                    ),
                  );
                  getData();
                }
              });
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('siwat jomewattana'),
              accountEmail: Text('s1104300051612@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.orange,
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: _keyword,
                onChanged: (String? value) {
                  //เมื่อพิมพ์ข้อมูล
                  if (value!.length >= 2) {
                    //ถ้าข้อมูล text box นี้มากกว่า 2 ตัว
                    search();
                  } else if (value.length < 2) {
                    getData();
                  }
                },
                decoration: InputDecoration(
                  hintText: "ค้นหา",
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Column(
              children: data.map((row) {
                //loop data
                return Column(
                  children: [
                    Mylist(
                      name: row['name'],
                      tel: row['tel'],
                      image: row['avatar'] == null
                          ? null
                          : Connect().url + "pic/" + row['avatar'].toString(),
                      edit: () {
                        Navigator.push(
                          //เปิดหน้าใหม่เพิ่มเข้ามา
                          context, //context เหมือนเป็นท่อลำเลียงส่ง widget ไปอีกหน้าหนึ่ง
                          MaterialPageRoute(
                            //แสดงหน้าใหม่เพิ่มเข้ามาตาม route
                            builder: (context) => Mydetail(
                              //ส่ง context ไปทำงานที่หน้า Mydetail
                              text: "edit", //ส่งข้อมูล text ชื่อ edit แนบไปด้วย
                              data: row,
                            ),
                          ),
                        ).then((value) {
                          if (value ?? false) {
                            //เช็คตัวแปร value ที่เข้ามาถ้าเป็น null จะบังคับให้ทำข้างหลังคือ false จะไม่ทำงาน ถ้ามีค่าไม่ใช่ null จะทำงาน
                            _scaffoldKey.currentState!.showSnackBar(
                              SnackBar(
                                content: Text("แก้ไขสำเร็จ"),
                              ),
                            );
                            getData();
                          }
                        });
                      },
                      delete: () {
                        delete(row['id'], row['avatar']);
                      },
                      ontab: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Mydetail(text: 'show', data: row),
                          ),
                        );
                      },
                    ),
                    MyWidget.buildDivider(),
                  ],
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
