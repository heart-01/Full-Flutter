import 'package:flutter/material.dart';
import 'package:smart_news/Screens/Bottomnavmenu/drawer_menu.dart';
import 'package:smart_news/Themes/colors.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Smart News',
          style: TextStyle(
            color: textColorSecondary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.video_call),
            onPressed: () {},
          )
        ],
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: googleColor), 
        child: const DrawerMenu()
      ),
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}
