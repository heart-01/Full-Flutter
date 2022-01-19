import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_news/Network/rest_api.dart';
import 'package:smart_news/Themes/colors.dart';
import 'package:smart_news/Utils/form_helper.dart';
import 'package:smart_news/Utils/utility.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //กำหนดตัวแปรเก็บ key
  final _sacffoldKey = GlobalKey<
      ScaffoldState>(); //กำหนดว่าตัวแปร _sacffoldKey จะเก็บคีย์ใน sacffold นี้
  static final GlobalKey<FormState> globalFormKey =
      GlobalKey<FormState>(); //กำหนดเพื่อไปผูกในฟอร์ม

  //กำหนดตัวแปรรับค่า username password
  String _username = "";
  String _password = "";
  bool hidePassword = true;
  bool isAPICallProcess = false; //ขึ้นโหลดข้อมูล

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      //ทำให้ไม่บัง status bar
      child: Scaffold(
        key: _sacffoldKey, //ผูก _sacffoldKey
        extendBodyBehindAppBar:
            true, //ให้เนื้อหาอยู่หลัง appbar ทำให้ดูเป็นเนื้อเดียวกัน
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent, //ทำให้พื้นหลังโปร่งแสง
        ),
        body: isAPICallProcess //เช็คว่าถ้าโหลดข้อมูลอยู่ให้แสดงรูปโหลดข้อมูล
            ? Center( child: CircularProgressIndicator() ) //รูปโหลดข้อมูล
            : GestureDetector(
                //ทริกการสร้าง GestureDetector คอบเพื่อให้เกิด Event Click จะได้ซ่อน Keyboard
                onTap: () {
                  FocusScope.of(context).unfocus();
                  print('touch screen');
                },
                child: SingleChildScrollView(
                  child: Form(
                    key: globalFormKey, //ผูก globalFormKey
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.start, //ให้แนวตั้ง Column ชิดซ้าย
                      crossAxisAlignment:
                          CrossAxisAlignment.start, //ให้แนวนอน Column ชิดซ้าย
                      children: [
                        Container(
                          width: double.infinity, //กว้างเต็มหน้าจอ
                          height: 200,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                //การไล่สี
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xffe64980), Color(0xffff8787)]),
                            borderRadius: BorderRadius.only(
                              //ปรับให้โค้ง
                              // bottomLeft: Radius.circular(80),
                              bottomRight: Radius.circular(80),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  radius: 50.0,
                                  backgroundImage: AssetImage(
                                      'assets/images/SignInLogo.png'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20, top: 40),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20.0,
                            bottom: 20.0,
                          ),
                          child: FormHelper.inputFieldWidget(
                            //สร้าง input จาก widget ที่สร้าง
                            context,
                            Icon(Icons.verified_user),
                            "username",
                            "username",
                            (onValidateVal) {
                              //validate form
                              if (onValidateVal.isEmpty) {
                                return 'Username is required';
                              }
                              return null;
                            },
                            (onSavedVal) {
                              _username = onSavedVal; //ดึงค่า text ใส่ในตัวแปร
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 20.0,
                          ),
                          child: FormHelper.inputFieldWidget(
                            //สร้าง input จาก widget ที่สร้าง
                            context,
                            Icon(Icons.verified_user),
                            "password",
                            "password",
                            (onValidateVal) {
                              //validate form
                              if (onValidateVal.isEmpty) {
                                return 'Password is required';
                              } 
                              // else if (!validateStructure(onValidateVal)) {
                              //   return 'Password Aszx1221';
                              // }
                              return null;
                            },
                            (onSavedVal) {
                              _password = onSavedVal; //ดึงค่า text ใส่ในตัวแปร
                            },
                            obscureText: hidePassword, //ซ่อน password
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              color: Colors.redAccent.withOpacity(0.5),
                              icon: Icon(hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: FormHelper.saveButton("Login", () async {
                            if (validateAndSave()) {
                              //ถ้าผ่านการ validate
                              print("Username: $_username");
                              print("Password: $_password");
                              //แสดงรูปโหลดข้อมูล
                              setState(() {
                                this.isAPICallProcess = true;
                              });     
                              //เรียกใช้ API เพื่อ Login
                              var response = await CallApi().loginCustomer(
                                { 
                                  "username" : _username, 
                                  "password" : _password
                                }
                              );
                              
                              var body = json.decode(response.body);
                                //ซ่อนรุปโหลดข้อมูล
                                setState(() {
                                  this.isAPICallProcess = false;
                                });

                                print(body);

                                if(body['success']){ //login ผ่าน
                                  // สร้าง Object SharedPrefernces หรือ ตัวแปร session จะต้องทำงานในรูปแบบ async , await
                                  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

                                  //เก็บค่าที่ต้องการลงตัวแปรแบบ sharedPreferences
                                  sharedPreferences.setString("storefirstName", body['data']['firstName']);
                                  sharedPreferences.setString("storelastName", body['data']['lastName']);
                                  sharedPreferences.setString("storeemail", body['data']['email']);

                                  //เก็บ Step data login เพื่อจำไว้ว่า login แล้วจะไม่ login ซ้ำ จนกว่าจะกด logout
                                  sharedPreferences.setInt("storeStep", 1);

                                  // ส่งไปหน้า dashboard
                                  Navigator.pushReplacementNamed(context, '/dashboard');
                                
                                }else{ //login ผิด แจ้งเตือนเป็น pop up
                                  Utility().showAlertDialog(context, "มีข้อผิดพลาด", "Username หรือ Password ไม่ถูกต้อง", "ตกลง");
                                  
                                  //ซ่อนรุปโหลดข้อมูล
                                  setState(() {
                                    this.isAPICallProcess = false;
                                  });
                                }     
                            }
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  /* Validate and Save form */
  bool validateAndSave() {
    final form = globalFormKey
        .currentState; //currentState คือ method ที่เข้าไปอ่านค่าใน Form //globalFormKey คือ ตัวแปรเก็บค่า key ของฟอร์ม
    if (form!.validate()) {
      //! คือการบังคับให้มีค่าเท่านั้น ห้ามเป็นค่า null
      form.save(); //การเรียก action submit Event on save ทำงานสัมพันกับ function onsave

      return true;
    }

    return false;
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
