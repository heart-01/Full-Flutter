import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CenterLayout extends StatefulWidget {
  const CenterLayout({ Key? key }) : super(key: key);

  @override
  State<CenterLayout> createState() => _CenterLayoutState();
}

class _CenterLayoutState extends State<CenterLayout> {

  void _onItemTapped(int index){
    setState(() {
      if (kDebugMode) {
        print(index);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello Flutter'),
      ),
      body: const Center(
        child: Text(
          'Hello Flutter',
          style: TextStyle(
            fontSize: 24.5,
          ),
        ),
      ),
      drawer: const Drawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile'
          ),
        ],
      ),
    );
  }
}