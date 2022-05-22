import 'package:flutter/material.dart';
import 'package:flutter_scale/screens/tabbarmenu/news_screen.dart';
import 'package:flutter_scale/screens/tabbarmenu/products_screen.dart';
import 'package:flutter_scale/screens/tabbarmenu/stores_screen.dart';
import 'package:flutter_scale/utils/constants.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(  // Tab
      length: 3, // จำนวน Tab
      child: Scaffold(
        appBar: PreferredSize( // PreferredSize กำหนดที่วาง Tab ว่าห่างจาก AppBar เท่าไรถ้าไม่กำหนด Tab จะมาทับ AppBar
          preferredSize: const Size.fromHeight(50.5),
          child: AppBar(
            bottom: const TabBar(
              labelStyle: TextStyle(fontSize: 16, fontFamily: 'NototSansThai',),
              labelColor: Colors.white,
              indicatorColor: Colors.amberAccent,
              tabs: [
                Tab(text: NEWS_MENU),
                Tab(text: PRODUCT_MENU),
                Tab(text: STORE_MENU),
              ],
            ),
          ),
        ),

        body: const TabBarView( // ตัวแสดงผลตาม TabBar
          children: [
            NewsScreen(),
            ProductScreen(),
            StoresScreen(),
          ],
        ),

      ),
    );
  }
}
