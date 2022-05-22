import 'package:flutter/material.dart';

class ButtonStart extends StatelessWidget {
  const ButtonStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 40.0), // padding ด้านนอกของ SizedBox
      child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(      // ElevatedButton เป็น Button ขนาดยาวเต็มบรรทัด
            onPressed: () {},
            child: const Text(
              'เริ่มต้นใช้งาน',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'NotoSansThai',
                fontWeight: FontWeight.bold // font จาก folder assets/fonts
              ),
            ),
            style: ButtonStyle(
              //MaterialStateProperty แก้ไขสีเป็นค่าสีเดียวสำหรับทุกสถานะ
              backgroundColor: MaterialStateProperty.all(Colors.white),
              textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20)),
              padding: MaterialStateProperty.all(const EdgeInsets.all(10)),     // padding ด้านในของ ElevatedButton
            ),
          )),
    );
  }
}
