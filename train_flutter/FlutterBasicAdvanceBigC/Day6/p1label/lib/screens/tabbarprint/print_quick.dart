import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:p1label/components/checkbox_custom.dart';
import 'package:p1label/components/elevated_full_button.dart';
import 'package:p1label/components/textfield_custom.dart';
import 'package:p1label/services/api.dart';
import 'package:p1label/themes/colors.dart';
import 'package:p1label/utils/constants.dart';

class PrintQuickScreen extends StatefulWidget {
  const PrintQuickScreen({Key? key}) : super(key: key);

  @override
  State<PrintQuickScreen> createState() => PrintQuickScreenState();
}

class PrintQuickScreenState extends State<PrintQuickScreen> {

  bool ckSF = false;
  bool ckBS = true;

  // สร้างตัวแปรรับคีย์ที่กด
  List<LogicalKeyboardKey> keys = [];

  // focusNode จะทำหน้าที่การเคลียค่าหน้าจอในกรณีที่ปิดหน้าจอนี้ไปแล้ว ทำให้ค้างหน้าการ focus เวลาเปิดหน้าอื่นที่รับค่าจาก keyboard เหมือนกันก็จะทำงาน _focusNode จะช่วยแก้ปัญหา
  final FocusNode _focusNode = FocusNode();
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  // S = จัดเก็บ
  void saveLabel(){
    //SnackBar คือ Popup ที่ด้านล่างขอบจอ
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: blueColor,
        content: Text('บันทึกรายการนี้แล้ว', textAlign: TextAlign.center),
      )
    );
  }

  // shift + p = พิมพ์
  void printLabel(){
    //SnackBar คือ Popup ที่ด้านล่างขอบจอ
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: dartGreenColor,
        content: Text('สั่งปริ้นรายการนี้แล้ว', textAlign: TextAlign.center),
      )
    );
  }

  // shift + q = ออก
  void backtoHome(){
    Navigator.pushNamed(context, '/home');
  }

  // ------------------------------------------------------------------------------------------------------------
  // data product ที่ได้จาก CallAPI
  List products = ['notFound'];

  void scanProduct(barcode) async {
    var data = await CallAPI().readProduct(barcode); // CallAPI readProduct ส่ง barcode เข้าไป

    // filter barcode ที่รับเข้ามา
    var ckBarcode = data.where((map)=>map["barcode"]==barcode).toList();
    products = (ckBarcode.isEmpty) ? ['notFound'] : ckBarcode;

    setState(() {
      
    });

    inspect(products);
  }

  @override
  void initState() {
    super.initState();
    // Call API first
    scanProduct('1111111111111');
  }
  // ------------------------------------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      // focusNode: FocusNode(), // สามารถเลือกใช้ focusNode เป็น Widget ก็ได้
      focusNode: _focusNode, // focusNode จะทำหน้าที่การเคลียค่าหน้าจอในกรณีที่ปิดหน้าจอนี้ไปแล้ว ทำให้ค้างหน้าการ focus
      onKey: (event){
        // S = จัดเก็บ
        if(event.isKeyPressed(LogicalKeyboardKey.keyS)){
          saveLabel();
        }
        // shift + p = พิมพ์
        if(event.isKeyPressed(LogicalKeyboardKey.shiftLeft) && event.isKeyPressed(LogicalKeyboardKey.keyP)){
          printLabel();
        }
        // shift + q = ออก
        if(event.isKeyPressed(LogicalKeyboardKey.f4) || 
          (event.isKeyPressed(LogicalKeyboardKey.shiftLeft) && event.isKeyPressed(LogicalKeyboardKey.keyQ)))
        {
          backtoHome();
        }
      },
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top:10.0, left: 10, right: 10),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.60,
                child: dataPrintQuick(
                  ckSF: ckSF,
                  onChangedSF: (val) {
                    setState(() {
                      ckSF = val!;
                      if (kDebugMode) {
                        print('Check SF: $ckSF');
                      }
                    });
                  },
                  ckBS: ckBS,
                  onChangedBS: (val) {
                    setState(() {
                      ckBS = val!;
                      if (kDebugMode) {
                        print('Check BS: $ckBS');
                      }
                    });
                  },
                  productList: products,
                ),
              ),
      
              // Button
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 8.0),
                child: ElevatedFullButton(
                  icon: Icons.settings_outlined,
                  iconColor: white_color,
                  iconSize: TEXT_SIZE_Normal,
                  name: 'กำหนดเครื่องพิมพ์ กดปุ่มนี้',
                  fontSize: TEXT_SIZE_SMedium,
                  height: 35,
                  textColor: white_color,
                  btnColor: primaryColor,
                  onPressed: (){
                    if (kDebugMode) {
                      print('Setting');
                    }
                  },
                ),
              ),
      
              // Button Group
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: ElevatedFullButton(
                        name: 'พิมพ์',
                        icon: Icons.print_outlined,
                        iconColor: white_color,
                        iconSize: TEXT_SIZE_Medium,
                        textColor: white_color,
                        btnColor: greenColor,
                        onPressed: printLabel,
                        height: 30,
                        fontSize: TEXT_SIZE_SMedium,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedFullButton(
                      name: 'จัดเก็บ',
                      icon: Icons.save_outlined,
                      iconColor: white_color,
                      iconSize: TEXT_SIZE_Medium,
                      textColor: white_color,
                      btnColor: Colors.purple,
                      onPressed: saveLabel,
                      height: 30,
                      fontSize: TEXT_SIZE_SMedium,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: ElevatedFullButton(
                        name: 'ออก',
                        icon: Icons.exit_to_app,
                        iconColor: white_color,
                        iconSize: TEXT_SIZE_Medium,
                        textColor: white_color,
                        btnColor: Colors.grey,
                        onPressed: (){
                          Navigator.popAndPushNamed(context, '/home');
                        },
                        height: 30,
                        fontSize: TEXT_SIZE_SMedium,
                      ),
                    ),
                  ),
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  // --------- Widget DataPrint ----------
  Widget dataPrintQuick({ 
    // Parameter 
    required bool ckSF, 
    required Function(bool?) onChangedSF, 
    required bool ckBS, 
    required Function(bool?) onChangedBS ,
    required List productList,
  }) {

  return Column(
    children: [
      Row(
        children: [
          const Expanded(
              flex: 2,
              child: Text("Bar:", style: TextStyle(fontSize: TEXT_SIZE_XSMALL))),
          Expanded(
            flex: 10,
            child: TextFieldCustom(
              readOnly: false,
              initialValue: (productList[0] == "notFound") ? "" : productList[0]["barcode"],
              maxLength: 13,
              textInputType: TextInputType.number,
              obscureText: false,
              autofocus: true,
              size: 6,
              bgColor: white_color,
              borderColor: darker_GrayColor,
              borderWidth: 1,
              borderRadius: 5,
              fontSize: TEXT_SIZE_XSMALL,
              fontWeight: FontWeight.bold,
              onFieldSubmitted:(val){
                scanProduct(val);
              }
            ),
          ),
          Expanded(
            flex: 10,
            child: TextFieldCustom(
              readOnly: true,
              initialValue: (productList[0] == "notFound") ? "" : productList[0]["rootcode"],
              textInputType: TextInputType.text,
              obscureText: false,
              autofocus: false,
              size: 6,
              bgColor: inputBgColor,
              borderColor: darker_GrayColor,
              borderWidth: 1,
              borderRadius: 5,
              fontSize: TEXT_SIZE_XSMALL,
            ),
          ),
        ],
      ),

      Row(
        children: [
          const Expanded(flex: 2,child: Text("")),
          Expanded(
            flex: 20,
            child: TextFieldCustom(
              readOnly: true,
              initialValue: (productList[0] == "notFound") ? "" : productList[0]["pname"],
              textInputType: TextInputType.text,
              obscureText: false,
              autofocus: false,
              size: 6,
              bgColor: inputBgColor,
              borderColor: darker_GrayColor,
              borderWidth: 1,
              borderRadius: 5,
              fontSize: TEXT_SIZE_XSMALL,
            ),
          ),
        ],
      ),

      Row(
        children: [
          const Expanded(
              flex: 2,
              child: Text("MD:", style: TextStyle(fontSize: TEXT_SIZE_XSMALL))),
          Expanded(
            flex: 12,
            child: TextFieldCustom(
              readOnly: true,
              initialValue: (productList[0] == "notFound") ? "" : productList[0]["md"],
              textInputType: TextInputType.text,
              obscureText: false,
              autofocus: false,
              size: 6,
              bgColor: inputBgColor,
              borderColor: darker_GrayColor,
              borderWidth: 1,
              borderRadius: 5,
              fontSize: TEXT_SIZE_XSMALL,
            ),
          ),
          Expanded(
            flex: 8,
            child: TextFieldCustom(
              readOnly: true,
              initialValue: (productList[0] == "notFound") ? "" : productList[0]["type"],
              textInputType: TextInputType.text,
              obscureText: false,
              autofocus: false,
              size: 6,
              bgColor: inputBgColor,
              borderColor: darker_GrayColor,
              borderWidth: 1,
              borderRadius: 5,
              fontSize: TEXT_SIZE_XSMALL,
            ),
          ),
        ],
      ),

      Row(
        children: [
          const Expanded(
              flex: 2,
              child: Text("ST:", style: TextStyle(fontSize: TEXT_SIZE_XSMALL))),
          Expanded(
            flex: 6,
            child: TextFieldCustom(
              readOnly: true,
              initialValue: (productList[0] == "notFound") ? "" : productList[0]["status"],
              textInputType: TextInputType.text,
              obscureText: false,
              autofocus: false,
              size: 6,
              bgColor: inputBgColor,
              borderColor: darker_GrayColor,
              borderWidth: 1,
              borderRadius: 5,
              fontSize: TEXT_SIZE_XSMALL,
            ),
          ),
          Expanded(
            flex: 8,
            child: TextFieldCustom(
              readOnly: true,
              initialValue: (productList[0] == "notFound") ? "" : productList[0]["pog"],
              textInputType: TextInputType.text,
              obscureText: false,
              autofocus: false,
              size: 6,
              bgColor: inputBgColor,
              borderColor: darker_GrayColor,
              borderWidth: 1,
              borderRadius: 5,
              fontSize: TEXT_SIZE_XSMALL,
            ),
          ),
          Expanded(
            flex: 6,
            child: TextFieldCustom(
              readOnly: true,
              initialValue: (productList[0] == "notFound") ? "" : productList[0]["ot"],
              textInputType: TextInputType.text,
              obscureText: false,
              autofocus: false,
              size: 6,
              bgColor: inputBgColor,
              borderColor: darker_GrayColor,
              borderWidth: 1,
              borderRadius: 5,
              fontSize: TEXT_SIZE_XSMALL,
            ),
          ),
        ],
      ),

      Row(
        children: [
          const Expanded(
              flex: 2,
              child: Text("SP:", style: TextStyle(fontSize: TEXT_SIZE_XSMALL))),
          Expanded(
            flex: 9,
            child: TextFieldCustom(
              readOnly: true,
              initialValue: (productList[0] == "notFound") ? "" : productList[0]["sp"],
              textInputType: TextInputType.text,
              obscureText: false,
              autofocus: false,
              size: 6,
              bgColor: inputBgColor,
              borderColor: darker_GrayColor,
              borderWidth: 1,
              borderRadius: 5,
              fontSize: TEXT_SIZE_XSMALL,
            ),
          ),
          const Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(left: 2),
                child: Text("NP:", style: TextStyle(fontSize: TEXT_SIZE_XSMALL)),
              )),
          Expanded(
            flex: 9,
            child: TextFieldCustom(
              readOnly: true,
              initialValue: (productList[0] == "notFound") ? "" : productList[0]["np"],
              textInputType: TextInputType.text,
              obscureText: false,
              autofocus: false,
              size: 6,
              bgColor: inputBgColor,
              borderColor: darker_GrayColor,
              borderWidth: 1,
              borderRadius: 5,
              fontSize: TEXT_SIZE_XSMALL,
            ),
          ),
        ],
      ),

      Row(
        children: [
          const Expanded(
              flex: 2,
              child: Text("BOH:", style: TextStyle(fontSize: TEXT_SIZE_XSSMALL))),
          Expanded(
            flex: 9,
            child: TextFieldCustom(
              readOnly: true,
              initialValue: (productList[0] == "notFound") ? "" : productList[0]["boh"],
              textInputType: TextInputType.text,
              obscureText: false,
              autofocus: false,
              size: 6,
              bgColor: (productList.isNotEmpty && int.parse(productList[0]['boh'].toString()) > 0) ? inputBgColor : btnLogoutColor,
              borderColor: darker_GrayColor,
              borderWidth: 1,
              borderRadius: 5,
              fontSize: TEXT_SIZE_XSMALL,
              fontColor: (productList.isNotEmpty && int.parse(productList[0]['boh'].toString()) > 0) ? textColorPrimary : white_color,
            ),
          ),
          const Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(left: 2),
                child: Text("BOD:", style: TextStyle(fontSize: TEXT_SIZE_XSSMALL)),
              )),
          Expanded(
            flex: 9,
            child: TextFieldCustom(
              readOnly: true,
              initialValue: (productList[0] == "notFound") ? "" : productList[0]["bod"],
              textInputType: TextInputType.text,
              obscureText: false,
              autofocus: false,
              size: 6,
              bgColor: inputBgColor,
              borderColor: darker_GrayColor,
              borderWidth: 1,
              borderRadius: 5,
              fontSize: TEXT_SIZE_XSMALL,
            ),
          ),
        ],
      ),

      Row(
        children: [
          const Expanded(
              flex: 2,
              child: Text("PZ:", style: TextStyle(fontSize: TEXT_SIZE_XSMALL))),
          Expanded(
            flex: 9,
            child: TextFieldCustom(
              readOnly: true,
              initialValue: (productList[0] == "notFound") ? "" : productList[0]["pz"],
              textInputType: TextInputType.text,
              obscureText: false,
              autofocus: false,
              size: 6,
              bgColor: inputBgColor,
              borderColor: darker_GrayColor,
              borderWidth: 1,
              borderRadius: 5,
              fontSize: TEXT_SIZE_XSMALL,
            ),
          ),
          const Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(left: 2),
                child: Text("P1:", style: TextStyle(fontSize: TEXT_SIZE_XSMALL)),
              )),
          Expanded(
            flex: 5,
            child: TextFieldCustom(
              readOnly: false,
              initialValue: (productList[0] == "notFound") ? "" : productList[0]["p1"],
              textInputType: TextInputType.number,
              obscureText: false,
              autofocus: false,
              size: 6,
              bgColor: white_color,
              borderColor: darker_GrayColor,
              borderWidth: 1,
              borderRadius: 5,
              fontSize: TEXT_SIZE_XSMALL,
            ),
          ),
          Expanded(
            flex: 4,
            child: CheckboxCustom(
              name: 'SF',
              fontSize: TEXT_SIZE_XSMALL,
              borderRadius: 5,
              val: ckSF,
              onChanged: onChangedSF,
            )
          )
        ],
      ),

      Row(
        children: [
          const Expanded(
              flex: 4,
              child: Text("บาร์ล่าสุด:", style: TextStyle(fontSize: TEXT_SIZE_XSSMALL))),
          const Expanded(
            flex: 14,
            child: TextFieldCustom(
              readOnly: true,
              // initialValue: '8851123212021',
              textInputType: TextInputType.text,
              obscureText: false,
              autofocus: false,
              size: 6,
              bgColor: inputBgColor,
              borderColor: darker_GrayColor,
              borderWidth: 1,
              borderRadius: 5,
              fontSize: TEXT_SIZE_XSMALL,
            ),
          ),
          Expanded(
            flex: 4,
            child: CheckboxCustom(
              name: 'B/S',
              fontSize: TEXT_SIZE_XSMALL,
              borderRadius: 5,
              val: ckBS,
              onChanged: onChangedBS,
            )
          )
        ],
      )

    ],
  );
}



}