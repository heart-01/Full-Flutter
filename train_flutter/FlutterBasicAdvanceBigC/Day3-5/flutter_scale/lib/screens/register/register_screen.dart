import 'package:flutter/material.dart';
import 'package:flutter_scale/components/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  // สร้างตัวแปรสำหรับไว้ผูกกับฟอร์ม
  final formKey = GlobalKey<FormState>();

    // สร้างตัวแปรไว้รับค่าจากฟอร์ม
  late String _fullname, _username, _password;
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
                                    AssetImage('assets/images/logobigc.png'),
                              )
                            ],
                          ),
                        ),
                        inputFieldWidget(
                          context, 
                          const Icon(Icons.person), 
                          "fullname", 
                          "ชื่อ-สกุล",
                          "ป้อนชื่อ-สกุล",
                          (onValidateVal){
                            if(onValidateVal.isEmpty){
                              return 'กรุณาป้อนชื่อ-สกุลก่อน';
                            }
                            return null;
                          }, 
                          (onSavedVal){
                            _fullname = onSavedVal;
                          },
                          keyboardType: TextInputType.text
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputFieldWidget(
                          context, 
                          const Icon(Icons.person), 
                          "username", 
                          "ชื่อผู้ใช้",
                          "ป้อนชื่อผู้ใช้",
                          (onValidateVal){
                            if(onValidateVal.isEmpty){
                              return 'กรุณาป้อนชื่อผู้ใช้ก่อน';
                            }
                            return null;
                          }, 
                          (onSavedVal){
                            _username = onSavedVal;
                          },
                          keyboardType: TextInputType.text
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputFieldWidget(
                          context, 
                          const Icon(Icons.lock), 
                          "password", 
                          "รหัสผ่าน",
                          "ป้อนรหัสผ่าน",
                          (onValidateVal){
                            if(onValidateVal.isEmpty){
                              return 'กรุณาป้อนรหัสผ่านก่อน';
                            } else if(onValidateVal.length < 4) {
                              return 'รหัสผ่านต้องไม่น้อยกว่า 4 ตัวอักษร';
                            }
                            return null;
                          }, 
                          (onSavedVal){
                            _password = onSavedVal;
                          },
                          obscureText: hidePassword,
                          suffixIcon: IconButton(
                          onPressed: (){
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            color: Colors.redAccent.withOpacity(0.9),
                            icon: Icon(
                              hidePassword ? Icons.visibility_off : Icons.visibility
                            ),
                          ),
                          keyboardType: TextInputType.text
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        
                        submitButton(
                          "ลงทะเบียน",
                          () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();

                              // print(_username);
                              // print(_password);

                              
                            }
                          }
                        ),
                        
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('เป็นสมาชิกอยู่แล้ว ?', style: TextStyle(fontSize: 16)),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/login');
                            },
                            child: const Text('เข้าสู่ระบบ', style: TextStyle(fontSize: 16)))
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
