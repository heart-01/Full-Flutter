import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({ Key? key }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.home), // logo ของ appBar
          title: const Text('Home'),
          actions: [  // action ทางขวามือของ appbar
            IconButton( // Icon แบบปุ่มกด
              onPressed: () {
                if (kDebugMode) {
                  print('Hello Flutter');
                }
              },
              icon: const Icon(Icons.notifications),
            ),
            IconButton(
              onPressed: () {
                if (kDebugMode) {
                  print('Hello Flutter');
                }
              },
              icon: const Icon(Icons.camera),
            ),
          ],
        ),
        body: const Center(
          child: Text('test'),
        ),
      );
  }
}