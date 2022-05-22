import 'package:flutter/material.dart';

class TextWelcome extends StatelessWidget {
  const TextWelcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'สวัสดี',
          style: TextStyle(
            fontSize: 36,
            color: Colors.white,
            fontFamily: 'NotoSansThai',   // font จาก folder assets/fonts
          ),
        ),
        Text(
          'ยินดีต้องรับสู่บริการโมบายแบงก์กิ้ง',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontFamily: 'NotoSansThai',
          ),
        ),
      ],
    );
  }
}
