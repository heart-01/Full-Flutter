import 'package:flutter/material.dart';

class ContainerLayout extends StatefulWidget {
  const ContainerLayout({ Key? key }) : super(key: key);

  @override
  State<ContainerLayout> createState() => _ContainerLayoutState();
}

class _ContainerLayoutState extends State<ContainerLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Container Layout'),
      ),
      body: Center(
        child: Container(
          width: 200.0,
          height: 200.0,
          
          // เรียกใช้งานสี ถ้ามีสีใน BoxDecoration ต้องห้ามกำหนดสีนอก BoxDecoration
          // color: const Colors.tealAccent,
          // color: const Colors.tealAccent[200],
          // color: const Color.fromARGB(255, 66, 165, 254),
          // color: const Color.fromRGBO(66, 160, 45, 0.5),
          // color: const Color(0xFFDD4B39),

          // BoxDecoration จะเป็นการตกแต่ง container
          decoration: BoxDecoration(    
            color: const Color(0xFFDD4B39),
            border: Border.all(width: 5, color: Colors.brown),
            // borderRadius: BorderRadius.circular(20),  // กำหนดกรอบโดยกำหนดค่าเอง
            shape: BoxShape.circle,         // กำหนดกรอบโดยใช้ Property ของ flutter
            image: const DecorationImage(   // กำหนดกรอบของ image ที่อยู่ใน container
              fit: BoxFit.cover,             // กำหนดให้รูปเต็มกรอบ
              image: NetworkImage('https://media.istockphoto.com/photos/cute-red-kitten-is-sleeping-on-his-back-and-smiling-paws-up-concept-picture-id1144982182?k=20&m=1144982182&s=612x612&w=0&h=VBL-PDRr9FddwkY4c7yBIkozv6669r-xNl-QJRRb1iw='),
            ),
          ),

          child: const Text(
            'This is my content',
            textAlign: TextAlign.center,
          ),
        ),
      )
    );
  }
}