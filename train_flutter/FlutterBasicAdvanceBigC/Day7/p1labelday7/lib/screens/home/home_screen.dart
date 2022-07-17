// ignore_for_file: prefer_const_constructors_in_immutables, avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p1label/components/IAppBar.dart';
import 'package:p1label/components/textfield_custom.dart';
import 'package:p1label/components/widgets.dart';
import 'package:p1label/themes/colors.dart';
import 'package:p1label/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // --------------------------------------------------------
  // สร้าง Object SharedPreferences
  late SharedPreferences? sharedPreferences;
  // ตัวแปรเก็บค่า infoUser หลัง login
  String? branchCode, branchName, ipAddress, modelAndroid;
  void getBranchCode() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      branchCode = sharedPreferences!.getString('branchCode');
      branchName = sharedPreferences!.getString('branchName');
      ipAddress = sharedPreferences!.getString('ipAddress');
      modelAndroid = sharedPreferences!.getString('modelAndroid');
    });
  }

  void logout() async {
    // สร้าง Object sharedprefference เพื่อจะลบข้อมูลที่อยู่ใน localstorage 
    sharedPreferences = await SharedPreferences.getInstance();
    // เคลียร์ค่า Sharedprefference ทั้งหมดออก
    sharedPreferences!.clear();
    // ส่งไปหน้า branchcode
    Navigator.of(context).pushReplacementNamed('/branchcode');
  }

  @override
  void initState() {
    super.initState();
    getBranchCode();
  }
  // --------------------------------------------------------

  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  // ฟังก์ชันส่งไปหน้า Print Label Screen
  void printLabelScreen(){
    Navigator.pushReplacementNamed(context, '/print-screen');
  }

  // สร้างตัวแปรไว้รับคียร์ที่กด
  List<LogicalKeyboardKey> keys = [];

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: _focusNode,
      onKey: (event){
        final key = event.logicalKey; // ตัวแปรรับค่า key ที่กดเข้ามา
        if(event is RawKeyDownEvent){
          // เช็คว่ามีการกด keys เดิมไปหรือยัง
          if(keys.contains(key)) return;
          // แสดงผล key ที่ได้
          //print(key);
          // Enter Key Event
          if(event.isKeyPressed(LogicalKeyboardKey.enter)){
            // print('You press enter');
            printLabelScreen();
          }

          if(event.isKeyPressed(
            LogicalKeyboardKey.f4) || 
            (event.isKeyPressed(LogicalKeyboardKey.shiftLeft) && 
            event.isKeyPressed(LogicalKeyboardKey.keyQ))){
              logout();
          }

          setState(() {keys.add(key);});
        }else{
          // ลบ key เดิมออกจาก list
          setState(() {keys.remove(key);});
        }
      },
      child: Scaffold(
        appBar: IAppBar(
          height: 35,
          title: 'Print P1 Label',
          child: Row(
            children: [
              SizedBox(
                height: 25,
                width: 60,
                child: TextButton(
                  onPressed: () {
                    logout();
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(redColor),
                      alignment: Alignment.topCenter,
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(Icons.exit_to_app_outlined,
                          color: white_color, size: TEXT_SIZE_SMALL),
                      Text(
                        "ออก",
                        style: TextStyle(
                          color: white_color,
                          fontSize: TEXT_SIZE_SMALL,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                      child: Table(
                        columnWidths: const {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(2),
                        },
                        border: TableBorder.all(color: white_color),
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(children: [
                            const Text("เลขที่สาขา",
                                style: TextStyle(fontSize: TEXT_SIZE_SMALL)),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: TextFieldCustom(
                                context: context,
                                key: UniqueKey(),
                                readOnly: true,
                                initialValue: branchCode,
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
                                key: UniqueKey(),
                                readOnly: true,
                                initialValue: branchName,
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
                                key: UniqueKey(),
                                readOnly: true,
                                initialValue: ipAddress,
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
                                key: UniqueKey(),
                                context: context,
                                readOnly: true,
                                initialValue: modelAndroid,
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
