import 'dart:convert';
import 'dart:io';
import 'package:book_phone/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Mydetail extends StatefulWidget {
  final String? text;
  final data;

  Mydetail({
    Key? key,
    this.text,
    this.data,
  }) : super(key: key);

  @override
  _MydetailState createState() => _MydetailState();
}

class _MydetailState extends State<Mydetail> {
  GlobalKey<FormState> _keyform = GlobalKey<
      FormState>(); //GlobalKey<FormState> รับค่าข้อมูลจากฟอร์ม _ private
  //สร้างตัวแปรรับค่า
  TextEditingController _name = TextEditingController();
  TextEditingController _nickname = TextEditingController();
  TextEditingController _tel = TextEditingController();
  TextEditingController _idline = TextEditingController();
  bool autovalidate = false;

  //Future function getImage
  File? _image;
  final picker = ImagePicker();
  Future<void> getImage(ImageSource imageSource) async {
    final pickedfile =
        await picker.getImage(source: imageSource); //แสดงรูปภาพจาก imageSource
    setState(() {
      if (pickedfile != null) {
        _image = File(pickedfile.path); //เอาพาธรูปไปใส่ในตัวแปร image
        print(_image);
      } else {
        print("No image selected");
      }
    });
    Navigator.pop(context); //ปิด modal alert
  }

  //upload file to folder pic api
  String? _namefile_old;
  String? _namefile;
  upload(String filePath, url) async {
    final postUri =
        Uri.parse(url); //แปลงข้อมูลของ ตัวแปร url ให้อยู่ในรูปแบบ URI
    // URI คือข้อมูลที่ใช้ระบุตัวตนของทรัพยากร (resource)
    // โดยที่ resource อาจจะเป็น data, image, file, service, website, หนังสือ, คน หรือ หน่วยงาน ก็ได้
    // เรียกว่าอะไรก็ได้ เอามาระบุตัวตน (identify) โดยทำให้ออกมาเป็นรูปแบบเดียวกัน (uniform)
    setState(() {
      _namefile = filePath
          .split('/')
          .last; //แยกตัว / ออกมาแต่ละส่วน แล้วเก็บค่าสุดท้ายเท่านั้น
    });
    final request = http.MultipartRequest(
        'POST', postUri); //set request ว่าจะเป็น POST ให้กับ url
    final multipartFile = await http.MultipartFile.fromPath(
        "sampleFile", filePath,
        filename:
            _namefile); //set ตัวไฟล์ from data  ใส่ sampleFile คือ key ที่ได้จาก api ใส่ name file แล้วเก็บในตัวแปร multipartFile
    request.files.add(multipartFile); //add files เข้าไปในการร้องขอ request
    http.StreamedResponse response = await request.send(); //ส่งค่าออกไป
    print(response.statusCode);
  }

  // check validate form
  String? checkempty(String? value) {
    if (value == '') {
      return 'กรุณากรอกข้อมูลช่องนี้';
    }
    return null;
  }

  check() {
    if (widget.text == 'add') {
      save();
    } else {
      update();
    }
  }

  Future<void> save() async {
    if (!_keyform.currentState!.validate()) {
      //เช็คว่าฟอร์มผ่านการ validation หรือไม่
      // true ไม่ผ่าน
      setState(() {
        autovalidate =
            true; //เปลี่ยนสถานะ autovalidate เป็น true ไม่ผ่านการ validation
      });
    } else {
      //false ผ่าน
      if (_image != null) {
        await upload(_image!.path,
            Connect().url + "upload"); //upload file to folder pic api
      }

      await Connect()
          .postData(
        'add_book',
        jsonEncode(
          {
            "nickname": _nickname.text,
            "name": _name.text,
            "tel": _tel.text,
            "avatar": _namefile,
            "id_line": _idline.text,
          },
        ),
      )
          .then((value) {
        if (value.statusCode == 200) {
          Navigator.pop(context, true); //pop กลับไปก่อนหน้า แล้วส่งค่ากลับไป
        }
      });
    }
  }

  Future<void> update() async {
    if (!_keyform.currentState!.validate()) {
      //เช็คว่าฟอร์มผ่านการ validation หรือไม่
      // true ไม่ผ่าน
      setState(() {
        autovalidate =
            true; //เปลี่ยนสถานะ autovalidate เป็น true ไม่ผ่านการ validation
      });
    } else {
      //false ผ่าน
      if (_image != null) {
        await upload(_image!.path,
            Connect().url + "upload"); //upload file to folder pic api
        if (_namefile_old != null)
          Connect().delFile('remove/photos/' + _namefile_old!);
      }

      await Connect()
          .editData(
        'update_book/' + widget.data['id'].toString(),
        jsonEncode(
          {
            "nickname": _nickname.text,
            "name": _name.text,
            "tel": _tel.text,
            "avatar": _namefile,
            "id_line": _idline.text,
          },
        ),
      )
          .then((value) {
        if (value.statusCode == 200) {
          Navigator.pop(context, true); //pop กลับไปก่อนหน้า แล้วส่งค่ากลับไป
        }
      });
    }
  }

  @override
  void initState() {
    if (widget.text == 'edit') {
      setState(() {
        _name.text = widget.data['name'];
        _tel.text = widget.data['tel'];
        _nickname.text = widget.data['nickname'];
        _idline.text = widget.data['id_line'];
        _namefile_old = widget.data['avatar'];
      });
    } else if (widget.text == 'show') {
      setState(() {
        _name.text = widget.data['name'];
        _tel.text = widget.data['tel'];
        _nickname.text = widget.data['nickname'];
        _idline.text = widget.data['id_line'];
        _namefile_old = widget.data['avatar'];
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.text == "add"
            ? 'เพิ่มข้อมูลข้อมูล'
            : widget.text == 'edit'
                ? 'แก้ไขข้อมูล'
                : 'แสดงข้อมูล'),
        actions: [
          Visibility(
            visible: (widget.text == 'show') ? false : true,
            child: FlatButton(
              onPressed: () {
                check();
              },
              child: Text('เสร็จสิ้น'),
              textColor: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20.0),
              child: _image != null
                  ? CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 60,
                      backgroundImage: FileImage(_image!),
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 60,
                      backgroundImage: _namefile_old != null &&
                              widget.text == 'edit'
                          ? NetworkImage("${Connect().url}/pic/$_namefile_old")
                          : _namefile_old != null && widget.text == 'show'
                              ? NetworkImage(
                                  "${Connect().url}/pic/$_namefile_old")
                              : NetworkImage(
                                  "https://www.pngrepo.com/download/263630/users-user.png"),
                    ),
            ),
            Visibility(
              visible: (widget.text == 'show') ? false : true,
              child: FlatButton(
                child: Text('เลือกรูป'),
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoActionSheet(
                      title: Text('เลือกรายการที่ต้องการ'),
                      actions: [
                        CupertinoActionSheetAction(
                          onPressed: () => getImage(ImageSource.camera),
                          child: Text('Camera'),
                        ),
                        CupertinoActionSheetAction(
                          onPressed: () => getImage(ImageSource.gallery),
                          child: Text('Gallery'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Form(
                  //สร้าง ฟอร์ม
                  key: _keyform, //ส่งค่า key ของฟอร์มให้ตัวแปร _keyform
                  autovalidate: autovalidate, //ส่งค่าการกรอกข้อมูลให้ตัวแปร
                  child: Column(
                    children: [
                      TextFormField(
                        enabled: (widget.text == 'show') ? false : true,
                        controller: _name, //ผูกการกรอกข้อมูลช่องนี้ให้กับตัวแปร
                        validator: checkempty, //ส่งข้อมูลช่องนี้ให้กับฟังชั่น
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.supervised_user_circle,
                          ),
                          hintText: 'ชื่อ',
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        enabled: (widget.text == 'show') ? false : true,
                        controller:
                            _nickname, //ผูกการกรอกข้อมูลช่องนี้ให้กับตัวแปร
                        validator: checkempty, //ส่งข้อมูลช่องนี้ให้กับฟังชั่น
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.supervised_user_circle,
                          ),
                          hintText: 'ชื่อเล่น',
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        enabled: (widget.text == 'show') ? false : true,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          LengthLimitingTextInputFormatter(10),
                        ],
                        controller: _tel, //ผูกการกรอกข้อมูลช่องนี้ให้กับตัวแปร
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'กรุณากรอกข้อมูลช่องนี้';
                          } else if (text.length < 10) {
                            return 'เบอร์โทรศัพท์ไม่ถูกต้อง';
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone,
                          ),
                          hintText: 'เบอร์โทร',
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        enabled: (widget.text == 'show') ? false : true,
                        controller:
                            _idline, //ผูกการกรอกข้อมูลช่องนี้ให้กับตัวแปร
                        validator: checkempty, //ส่งข้อมูลช่องนี้ให้กับฟังชั่น
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(' ')),
                        ],
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.info_outline,
                          ),
                          hintText: 'Id Line',
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: (widget.text == 'add' || widget.text == 'edit') ? false : true,
        child: FloatingActionButton(
          onPressed: () async {
            bool? res = await FlutterPhoneDirectCaller.callNumber(_tel.text);
          },
          child: Icon(
            Icons.phone,
          ),
        ),
      ),
    );
  }
}
