import 'package:flutter/material.dart';
import 'package:flutter_scale/themes/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({ Key? key }) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  // สร้างตัวแปรสำหรับไว้ผูกกับฟอร์ม
  final formKey = GlobalKey<FormState>();
  
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
              child: Form(
                // สร้างฟอร์มรับค่าข้อมูล
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(      // TextField
                      autofocus: true,  // focus ตอนเริ่มต้น
                      keyboardType: TextInputType.text,   // กำหนดว่า input ช่องนี้จะใส่ข้อมูลอะไร ปกติ Default จะเป็น text
                      style:
                          const TextStyle(fontSize: 20, color: inputTextColor),
                      decoration: const InputDecoration(
                          icon: Icon(Icons.article_outlined, size: 24),
                          labelText: 'Fullname',
                          hintText: 'ป้อนชื่อ-สกุล',
                          hintStyle: TextStyle(fontSize: 16, color: inputTextColor),
                      ),
                    ),

                    TextFormField(    
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      style:
                          const TextStyle(fontSize: 20, color: inputTextColor),
                      decoration: const InputDecoration(
                          icon: Icon(Icons.person, size: 24),
                          labelText: 'Usrename',
                          hintText: 'ป้อนชื่อผู้ใช้งาน',
                          hintStyle: TextStyle(fontSize: 16, color: inputTextColor),
                      ),
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
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text('ลงทะเบียน'),
                      ),
                    ),

                    const SizedBox(height: 40,),

                    const Text('เป็นสมาชิกอยู่แล้ว ?',),
                    
                    TextButton(
                      onPressed: (){
                        Navigator.of(context).pushReplacementNamed('/login'); // เปิดหน้าแล้ว login ทับหน้าปัจจุบัน
                      }, 
                      child: const Text('เข้าสู่ระบบ'),
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