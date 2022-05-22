import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale/services/rest_api.dart';
import 'package:flutter_scale/themes/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // สร้างตัวแปรสำหรับไว้ผูกกับฟอร์ม
  final formKey = GlobalKey<FormState>();

  // สร้างตัวแปรรับค่าฟอร์ม
  late String _username, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(    // GestureDetector จะคอยเช็คการกดของ User ภายใน Screen เมื่อไม่ได้ focus TextField
        onTap: () {             // เมื่อ Tap นอกเหนือจาก TextField
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(   // SingleChildScrollView เป็น Widget ที่สามารถเลื่อนลงได้อย่างอิสระไม่ล้นหน้าจอ
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Form(              // สร้างฟอร์มรับค่าข้อมูล
                key: formKey,           // ผูก formKey
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(      // TextField
                      autofocus: true,  // focus ตอนเริ่มต้น
                      keyboardType: TextInputType.text,   // กำหนดว่า input ช่องนี้จะใส่ข้อมูลอะไร ปกติ Default จะเป็น text
                      style:
                          const TextStyle(fontSize: 20, color: inputTextColor),
                      decoration: const InputDecoration(
                          icon: Icon(Icons.person, size: 24),
                          labelText: 'Username',
                          hintText: 'ป้อนชื่อผู้ใช้งาน',
                          hintStyle: TextStyle(fontSize: 16, color: inputTextColor),
                      ),
                      validator: (value){       // validate data value ของ TextFild นี้
                        if(value!.isEmpty){     // value! คือ ต้องมีข้อมูลในฟอร์มก่อนถึงจะไม่เข้าเคสนี้ ส่วน ? จะมีข้อมูหรือไ่มีก็ได้
                          return 'กรุณาป้อนชื่อผู้ใช้งานก่อน';
                        }else{
                          return null;
                        }
                      },
                      onSaved: (value){
                        _username = value.toString().trim();  // trim String ใน TextField
                      }
                    ),

                    TextFormField(
                      autofocus: false,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontSize: 20, color: inputTextColor),
                      decoration: const InputDecoration(
                          icon: Icon(Icons.lock, size: 24),
                          labelText: 'Password',
                          hintText: 'ป้อนรหัสผ่าน',
                          hintStyle: TextStyle(fontSize: 16, color: inputTextColor),
                      ),
                      validator: (value){       // validate data value ของ TextFild นี้
                        if(value!.isEmpty){     // value! คือ ต้องมีข้อมูลในฟอร์มก่อนถึงจะไม่เข้าเคสนี้ ส่วน ? จะมีข้อมูหรือไ่มีก็ได้
                          return 'กรุณารหัสผ่านก่อน';
                        }else if(value.length < 8){
                          return 'รหัสผ่านต้องไม่น้อยกว่า 8 ตัวอักษร';
                        }else{
                          return null;
                        }
                      },
                      onSaved: (value){
                        _password = value.toString().trim();  // trim String ใน TextField
                      }
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            if(formKey.currentState!.validate()){   // เช็ค validate ของฟอร์ม
                              formKey.currentState!.save();         // สั่ง onSaved ข้อมูลลงตัวแปร

                              //เรียกใช้ LoginAPI
                              var response = await CallAPI().loginAPI(
                                {
                                  "username": _username,
                                  "password": _password
                                }
                              );

                              var body = json.decode(response.body);

                              if (kDebugMode) {
                                print(_username);
                                print(_password);
                                print(body);
                              }

                              // เช็ค body status และ body data หลังจาก call API
                              if(body['status'] == 'success' && body['data']['status'] == '1')
                              {
                                // สร้าง Object sharedprefference เพื่อจะเก็บข้อมูลลง localstorage 
                                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

                                // เก็บค่าที่ต้องการลงในตัวแปร Object SharedPreferences
                                sharedPreferences.setInt('userStep', 1); // userStep ไว้เช็คข้อมูล user ผ่านการ login แล้วรึยัง
                                sharedPreferences.setString('userName', _username); // userName ไว้เก็บข้อมูล username ตอนผ่าน login 
                                sharedPreferences.setString('fullName', body['data']['fullname']);
                                sharedPreferences.setString('imgProfile', body['data']['img_profile']);

                                // ส่งไปหน้า DashboardScreen
                                Navigator.of(context).pushReplacementNamed('/dashboard');

                              }else{
                                // set up the button
                                Widget cancelButton = TextButton(
                                  child: const Text("ยกเลิก"),
                                  onPressed:  () {
                                    Navigator.of(context).pop();
                                  },
                                );
                                Widget confirmButton = TextButton(
                                  child: const Text("ตกลง"),
                                  onPressed:  () {
                                    // ส่งไปหน้า HomeScreen
                                    Navigator.of(context).pushReplacementNamed('/register');
                                  },
                                );

                                // set up the AlertDialog
                                AlertDialog errLogin = AlertDialog (
                                  title: const Text('มีข้อผิดพลาด'),
                                  content: const Text('ข้อมูลเข้าระบบไม่ถูกต้อง \n คุณต้องการลงทะเบียน ?'),
                                  actions: [
                                    confirmButton,
                                    cancelButton
                                  ],
                                );

                                // show the dialog
                                showDialog(
                                  barrierDismissible: false, // ป้องกันปิด dialog โดยไม่กดปุ่มภายใน dialog
                                  context: context, 
                                  builder: (BuildContext context) {
                                    return errLogin;
                                  }
                                );
                              }
                            }
                          }, 
                          child: const Text('เข้าสู่ระบบ'),
                      ),
                    ),

                    const SizedBox(height: 40,),

                    const Text('ยังไม่เป็นสมชิก ?',),

                    TextButton(
                      onPressed: (){
                        Navigator.of(context).pushReplacementNamed('/register'); // เปิดหน้าแล้ว register ทับหน้าปัจจุบัน
                      }, 
                      child: const Text('ลงทะเบียน'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
