import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_scale/components/widgets.dart';
import 'package:flutter_scale/services/rest_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

// |----- Login Screen แบบใหม่ Form จะถูกสร้างจาก Widget แยกทำให้สามารถใช้งานได้หลายจุดจาก Widget เดียว

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // สร้างตัวแปรสำหรับไว้ผูกกับฟอร์ม
  final formKey = GlobalKey<FormState>();

  // สร้างตัวแปรไว้รับค่าจากฟอร์ม
  late String _username, _password;
  bool hidePassword = true;
  bool isAPICallProcess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircleAvatar(
                                radius: 30.0,
                                backgroundImage:
                                    AssetImage('assets/images/logobigc.webp'),
                              )
                            ],
                          ),
                        ),
                        inputFieldWidget(
                            context,
                            const Icon(Icons.person),
                            "username",
                            "ชื่อผู้ใช้",
                            "ป้อนชื่อผู้ใช้", (onValidateVal) {
                          if (onValidateVal.isEmpty) {
                            return 'กรุณาป้อนชื่อผู้ใช้ก่อน';
                          }
                          return null;
                        }, (onSavedVal) {
                          _username = onSavedVal;
                        }, keyboardType: TextInputType.text,
                      ),
                        const SizedBox(
                          height: 20,
                        ),
                        inputFieldWidget(
                            context,
                            const Icon(Icons.lock),
                            "password",
                            "รหัสผ่าน",
                            "ป้อนรหัสผ่าน", (onValidateVal) {
                          if (onValidateVal.isEmpty) {
                            return 'กรุณาป้อนรหัสผ่านก่อน';
                          } else if (onValidateVal.length < 4) {
                            return 'รหัสผ่านต้องไม่น้อยกว่า 4 ตัวอักษร';
                          }
                          return null;
                        }, (onSavedVal) {
                          _password = onSavedVal;
                        },
                            obscureText: hidePassword,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              color: Colors.redAccent.withOpacity(0.9),
                              icon: Icon(hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                            keyboardType: TextInputType.text),
                        const SizedBox(
                          height: 20,
                        ),
                        submitButton("เข้าสู่ระบบ", () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();

                            // print(_username);
                            // print(_password);

                            // เรียกใช้ LoginAPI
                            var response = await CallAPI().loginAPI(
                                {"username": _username, "password": _password});

                            var body = json.decode(response.body);

                            if (body['status'] == 'success' &&
                                body['data']['status'] == '1') {
                              // สร้าง Object แบบ SharedPreferences
                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();

                              // เก็บค่าที่ต้องการลงในตัวแปรแบบ SharedPreferences
                              sharedPreferences.setInt('userStep', 1);
                              sharedPreferences.setString(
                                  'userName', _username);
                              sharedPreferences.setString(
                                  'fullName', body['data']['fullname']);
                              sharedPreferences.setString(
                                  'imgProfile', body['data']['img_profile']);

                              // ส่งไปหน้า HomeScreen
                              Navigator.of(context)
                                  .pushReplacementNamed('/dashboard');
                            } else {
                              AlertDialog alert = AlertDialog(
                                title: const Text('มีข้อผิดพลาด'),
                                content: const Text('ข้อมูลเข้าระบบไม่ถูกต้อง'),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('OK'))
                                ],
                              );

                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  });
                            }
                          }
                        }),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text('ยังไม่เป็นสมาชิก ?',
                            style: TextStyle(fontSize: 16)),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/register');
                            },
                            child: const Text('ลงทะเบียนที่นี่',
                                style: TextStyle(fontSize: 16)))
                      ],
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
