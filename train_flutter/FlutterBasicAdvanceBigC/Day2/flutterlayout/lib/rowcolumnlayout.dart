import 'package:flutter/material.dart';

class RowColumnLayout extends StatefulWidget {
  const RowColumnLayout({ Key? key }) : super(key: key);

  @override
  State<RowColumnLayout> createState() => _RowColumnLayoutState();
}

class _RowColumnLayoutState extends State<RowColumnLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Row Column Layout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
              ],
            ),
          ],
        ),
      ),

      // Row(
      //   // จัดตำแหน่งแนวนอน
      //   // mainAxisAlignment: MainAxisAlignment.start,
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   // mainAxisAlignment: MainAxisAlignment.end,
      //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   // mainAxisAlignment: MainAxisAlignment.spaceAround,
      //   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   children: const [
      //     Icon(Icons.star),
      //     Icon(Icons.star),
      //     Icon(Icons.star),
      //   ],
      // ),
      // Column(
      //   // จัดตำแหน่งแนวตั้ง
      //   // crossAxisAlignment: CrossAxisAlignment.center,
      //   children: const [
      //     Icon(Icons.star),
      //     Icon(Icons.star),
      //     Icon(Icons.star),
      //   ],
      // ),

    );
  }
}