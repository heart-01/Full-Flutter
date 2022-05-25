// ignore_for_file: prefer_const_constructors_in_immutables, avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p1label/components/IAppBar.dart';
import 'package:p1label/components/textfield_custom.dart';
import 'package:p1label/components/widgets.dart';
import 'package:p1label/themes/colors.dart';
import 'package:p1label/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // ฟังก์ชั่นส่งไปหน้า Print Lable Screen
  void printLabelScreen(){
    Navigator.pushReplacementNamed(context, '/print-screen');
  }

  // ฟังก์ชั่นออกจากหน้า home ไปหน้า branch code
  void backtoBranch(){
    Navigator.pushNamed(context, '/branchcode');
  }

  // สร้างตัวแปรรับคีย์ที่กด
  List<LogicalKeyboardKey> keys = [];

  // focusNode จะทำหน้าที่การเคลียค่าหน้าจอในกรณีที่ปิดหน้าจอนี้ไปแล้ว ทำให้ค้างหน้าการ focus เวลาเปิดหน้าอื่นที่รับค่าจาก keyboard เหมือนกันก็จะทำงาน _focusNode จะช่วยแก้ปัญหา
  final FocusNode _focusNode = FocusNode();
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener( // เช็คการกด Keyboard โดยที่ไม่ได้อยู่ใน text field เหมือนกดปุ่มกดโทรศัพท์
      autofocus: true,
      // focusNode: FocusNode(), // สามารถเลือกใช้ focusNode เป็น Widget ก็ได้
      focusNode: _focusNode, // focusNode จะทำหน้าที่การเคลียค่าหน้าจอในกรณีที่ปิดหน้าจอนี้ไปแล้ว ทำให้ค้างหน้าการ focus
      onKey: (event){
        final key = event.logicalKey; // ตัวแปรรับค่า key ที่กดเข้ามา
        if(event is RawKeyDownEvent)  // ถ้ามีการกดปุ่ม Keyboard
        { 
          // แสดงผล key ที่ได้
          if (kDebugMode) {
            print(key);
          }
          
          if(keys.contains(key)) return; // เช็คว่าตัวแปร keys ที่เก็บค่าไว้ ซ้ำกับการกด keys รอบใหม่หรือไม่ ถ้าใช่ return null ออกไป

          // เช็คว่ากด enter เท่ากับไปหน้าถัดไป
          if(event.isKeyPressed(LogicalKeyboardKey.enter)){
            if (kDebugMode) {
              print('You press enter');
            }
            printLabelScreen();
          }
          // เช็คว่ากดปุ่ม f4 หรือ shiftLeft + Q เท่ากับ กลับไป
          if(event.isKeyPressed(LogicalKeyboardKey.f4) || 
            (event.isKeyPressed(LogicalKeyboardKey.shiftLeft) && event.isKeyPressed(LogicalKeyboardKey.keyQ))) 
          {
            backtoBranch();
          }

          setState(() {
            keys.add(key); // เพิ่มค่า keys คีย์ที่กดรอบใหม่
            inspect(keys);
          });
        }else{
          // ลบ keys เดิมออกจาก list
          setState(() {
            keys.remove(key);
          });
        }
      },
      child: Scaffold(
        appBar: IAppBar(
          height: 35,
          title: 'Print P1 Label',
          child: btnLogout(context),
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                child: Column(
                  children: [
                    headerWidget(context),
                    Expanded(
                        // Show Data
                        child: Container(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 10.0),
                      child: Table(
                        columnWidths: const {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(2),
                        },
                        border: TableBorder.all(color: white_color),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(children: [
                            const Text("เลขที่สาขา",
                                style: TextStyle(fontSize: TEXT_SIZE_SMALL)),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: TextFieldCustom(
                                context: context,
                                readOnly: true,
                                initialValue: '11108',
                                textInputType: TextInputType.text,
                                obscureText: false,
                                autofocus: false,
                                size: 5,
                                bgColor: inputBgColor,
                                borderColor: inputBgColor,
                                borderWidth: 1,
                                borderRadius: 5.0,
                                fontSize: TEXT_SIZE_SMALL,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            const Text("ชื่อสาขา",
                                style: TextStyle(fontSize: TEXT_SIZE_SMALL)),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: TextFieldCustom(
                                context: context,
                                readOnly: true,
                                initialValue: 'HHRSC1',
                                textInputType: TextInputType.text,
                                obscureText: false,
                                autofocus: false,
                                size: 5,
                                bgColor: inputBgColor,
                                borderColor: inputBgColor,
                                borderWidth: 0,
                                borderRadius: 5.0,
                                fontSize: TEXT_SIZE_SMALL,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ]),
                          TableRow(children: [
                            const Text("ไอพี",
                                style: TextStyle(fontSize: TEXT_SIZE_SMALL)),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: TextFieldCustom(
                                context: context,
                                readOnly: true,
                                initialValue: '192.138.43.179',
                                textInputType: TextInputType.text,
                                obscureText: false,
                                autofocus: false,
                                size: 5,
                                bgColor: inputBgColor,
                                borderColor: inputBgColor,
                                borderWidth: 0,
                                borderRadius: 5.0,
                                fontSize: TEXT_SIZE_SMALL,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ]),
                          TableRow(children: [
                            const Text("ชื่อเครื่อง",
                                style: TextStyle(fontSize: TEXT_SIZE_SMALL)),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: TextFieldCustom(
                                context: context,
                                readOnly: true,
                                initialValue: 'MSI-291994-NB',
                                textInputType: TextInputType.text,
                                obscureText: false,
                                autofocus: false,
                                size: 5,
                                bgColor: inputBgColor,
                                borderColor: inputBgColor,
                                borderWidth: 0,
                                borderRadius: 5.0,
                                fontSize: TEXT_SIZE_SMALL,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ]),
                        ],
                      ),
                    )),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: submitButton("Print P1 Label: ENT", () async {
                        printLabelScreen();
                      }),
                    ),
                    SizedBox(height: 20,),
                    footerWidget()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
