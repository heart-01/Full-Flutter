import 'package:flutter/material.dart'; //เรียกใช้ widget ui ของ android
// import 'package:flutter/cupertino.dart'; //เรียกใช้ widget ui ของ ios

void main(){
  runApp( //Widget runApp สั่งให้เรียกใช้งานเริ่มต้น
    MyApp()
  );
}



class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) { //Widget BuildContext แยก Widget ออกมาแล้ว build เป็น context ให้ MyApp เรียกใช้
    return MaterialApp( //Widget MaterialApp เรียกหน้าจอออกมา
      home: MyHomePage() 
    );
  }
}



class MyHomePage extends StatefulWidget {

  const MyHomePage({ Key? key }) : super(key: key); //Contuc

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold( //Widget Scaffold หน้าจอเริ่มต้น บังคับต้องมี Widget body ไม่บังคับต้องมี Widget appBar, title
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Center ( //Widget Center จัดกึ่งกลาง
          child: Text('สวัสดี flutter') //Widget Text แสดงตัวอักษร
        ),

        floatingActionButton: FloatingActionButton( //Widget FloatingActionButton ปุ่มลอยบนหน้าจอ
          child: Icon(Icons.add),
          onPressed: (){ //Event เมื่อกดปุ่มนี้
            print('Your Press');
          },
        ),

        drawer: Drawer( //Widget Drawer ปุ่มแฮมเบอเกอร์ด้านซ้ายบน
            child: Center(),
        ),

        bottomNavigationBar: BottomNavigationBar( //Widget BottomNavigationBar ปุ่มเมนูแถบด้านล่าง
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home)
            ),
            BottomNavigationBarItem(
              label: 'About',
              icon: Icon(Icons.access_alarm)
            ),
            BottomNavigationBarItem(
              label: 'Contact',
              icon: Icon(Icons.contact_mail)
            ),
          ],
        ),
      );
  }
}