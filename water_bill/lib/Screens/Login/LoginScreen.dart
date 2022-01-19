import 'package:flutter/material.dart';
import 'package:water_bill/Themes/colors.dart';
import 'package:water_bill/Utils/FormLogin.dart';
import 'package:water_bill/Utils/constant.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var isDarkMode;
  final _sacffoldKey = GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  String _username = "";
  String _password = "";
  bool hidePassword = true;
  bool isAPICallProcess = false;

  @override
  Widget build(BuildContext context) {

    isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      //ทำให้ไม่บัง status bar
      child: Scaffold(
        key: _sacffoldKey, //ผูก _sacffoldKey
        extendBodyBehindAppBar: true, //ให้เนื้อหาอยู่หลัง appbar ทำให้ดูเป็นเนื้อเดียวกัน
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
                                colors: (isDarkMode == true) ? [Color(0xffffff), Color(0xffffff)] : [Color(0xffe64980), Color(0xffff8787)]),
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
                                  radius: 65.0,
                                  backgroundImage: AssetImage('assets/images/SignInLogo.png'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20, top: 40),
                            child: Text(
                              "ระบบประปาดอนพุทรา หมู่ 4",
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
                          child: FormLogin.inputFieldWidget(
                            //สร้าง input จาก widget ที่สร้าง
                            context,
                            Icon(Icons.people_alt),
                            "username",
                            "ชื่อผู้ใช้งาน",
                            isDarkMode,
                            (onValidateVal) {
                              //validate form
                              if (onValidateVal.isEmpty) {
                                return '* กรุณากรอกชื่อผู้ใช้งาน';
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
                          child: FormLogin.inputFieldWidget(
                            //สร้าง input จาก widget ที่สร้าง
                            context,
                            Icon(Icons.vpn_key),
                            "password",
                            "รหัสผ่าน",
                            isDarkMode,
                            (onValidateVal) {
                              //validate form
                              if (onValidateVal.isEmpty) {
                                return '* กรุณากรอกรหัสผ่าน';
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
                              color: (isDarkMode == true) ? AppColors.white : Colors.redAccent.withOpacity(0.5),
                              icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: FormLogin.saveButton(
                            "เข้าสู่ระบบ", 
                            isDarkMode,
                            () async {
                              if (validateAndSave()) {
                                //ถ้าผ่านการ validate
                                print("Username: $_username");
                                print("Password: $_password");
                                //แสดงรูปโหลดข้อมูล
                                setState(() {
                                  this.isAPICallProcess = true;
                                });    
                              }
                            }, 
                          ),
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
      //ตัว ! คือการบังคับให้มีค่าเท่านั้น ห้ามเป็นค่า null
      form.save(); //การเรียก action submit Event on save ทำงานสัมพันกับ function onsave

      return true;
    }

    return false;
  }

  bool validateStructure(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

}