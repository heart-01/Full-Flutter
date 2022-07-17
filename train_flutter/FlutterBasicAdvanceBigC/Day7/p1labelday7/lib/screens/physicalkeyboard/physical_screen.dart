// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhysicalKeyboardScreen extends StatefulWidget {
  PhysicalKeyboardScreen({Key? key}) : super(key: key);

  @override
  State<PhysicalKeyboardScreen> createState() => _PhysicalKeyboardScreenState();
}

class _PhysicalKeyboardScreenState extends State<PhysicalKeyboardScreen> {

  final FocusNode _focusNode = FocusNode();

  // ไว้เก็บ List ของ Key ที่กดเข้ามา
  List<LogicalKeyboardKey> keys = [];

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: _focusNode,

      onKey: (event){
        
        final key = event.logicalKey; // เก็บ key ที่กด
        if(event is RawKeyDownEvent){

          // แสดงผล key ที่กด
          print(key);

          if(keys.contains(key)) return; // เช็คไม่ให้กด key ค้างไว้

          // Press Enter
          if(event.isKeyPressed(LogicalKeyboardKey.enter)){
            print('You pressed Enter');
            // inspect(keys);
          }

          // Press Shift + P
          if(event.isKeyPressed(LogicalKeyboardKey.shiftLeft) && event.isKeyPressed(LogicalKeyboardKey.keyP)){
            print('Your pressd Shift+P');
          }

          // Press Shift + Q
          if(event.isKeyPressed(LogicalKeyboardKey.shiftLeft) && event.isKeyPressed(LogicalKeyboardKey.keyQ)){
            print('Your pressd Shift+Q');
          }

          // เพิ่ม key เข้าไปใน list
          setState(() => keys.add(key));

        }else{
          // ลบ key ออกจาก list
          setState(() => keys.remove(key)); 
        }

      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Keyboard Event'),
        ),
        body: keys.isNotEmpty ? ListView.builder(
          itemCount: keys.length,
          itemBuilder: (context, index){
            LogicalKeyboardKey key = keys[index];
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 80),
              child: ElevatedButton(
                onPressed: (){}, 
                child: Text(key.debugName.toString())
              ),
            );
          }
        ): Center(child: ElevatedButton(onPressed: (){}, child: Text('None'))),
      ),
    );
  }
}