import 'package:flutter/material.dart';

void main(){
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('หน้าหลัก'),
        ),
        body: Center(
          child: Text('สวัสดี flutter')
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            print('Your press');
          },
        ),
        drawer: Drawer(
          child: Center(),
        ),
        
        bottomNavigationBar: BottomNavigationBar(
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
              )
            ]
          )
    );
  }
}