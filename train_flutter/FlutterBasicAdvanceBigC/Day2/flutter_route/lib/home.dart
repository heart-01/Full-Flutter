import 'package:flutter/material.dart';
import 'package:flutter_route/about.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('HomeScreen'),
            ElevatedButton(
              onPressed: (){
                // ไปหน้า AboutScreen โดย push สามารถ back กลับมาได้
                // Navigator.of(context).push(
                //   MaterialPageRoute(builder: (context) => const AboutScreen())
                // );

                // ไปหน้า AboutScreen โดย push ไม่สามารถ back กลับมาได้
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(builder: (context) => const AboutScreen())
                // );

                // ไปหน้า AboutScreen โดยเรียกใช้ชื่อ Url จาก Routers
                Navigator.pushNamed(context, '/about');
                
              },
              child: const Text('Go to about'),
            ),
          ],
        ),
      ),
    );
  }
}