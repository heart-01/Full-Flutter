import 'package:flutter/material.dart';

class ExpandLayout extends StatefulWidget {
  const ExpandLayout({ Key? key }) : super(key: key);

  @override
  State<ExpandLayout> createState() => _ExpandLayoutState();
}

class _ExpandLayoutState extends State<ExpandLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expanded Layout'),
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            color: Colors.green,
          ),
          // กระจายเต็มหน้าจอแล้วสามารถแบ่งระยะอัตราส่วนได้โดยใช้ Expanded จะเป็น Reponseve โดยอัติโนมัติ คำนวณระยะจากพื้นที่ใน body
          Expanded(
            flex: 10, // กำหนดให้ Expanded ใช้พื้นที่ 10 ส่วนของ body ที่เหลือ
            child: Container(
              width: double.infinity, // double.infinity จะเป็นการกำหนดให้เต็มพื้นที่
              color: Colors.yellow,
              child: Column(
                children: const [
                  SizedBox(height: 40,),  // SizedBox จะใช้คั่นระหว่าง Widget
                  Text("Welcome"),
                  SizedBox(height: 20,),
                  Text("To My App"),
                ],
              ),
            )
          ),
          Expanded(
            flex: 1,
            child: Container(color: Colors.blue,)
          ),
        ],
      ),
    );
  }
}