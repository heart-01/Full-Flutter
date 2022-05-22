import 'package:flutter/material.dart';
import 'package:smart_news/Screens/Bottomnavmenu/BookmarkFragment.dart';
import 'package:smart_news/Screens/Bottomnavmenu/CategoryFragment.dart';
import 'package:smart_news/Screens/Bottomnavmenu/HomeFragment.dart';
import 'package:smart_news/Screens/Bottomnavmenu/ProfileFragment.dart';
import 'package:smart_news/Screens/Bottomnavmenu/SearchFragment.dart';
import 'package:smart_news/Themes/colors.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0; //กำหนดแถบตัวแรกที่ตอนเปิดแอพ

  // ลำดับของหน้า widget page ที่จะ render ต้องอ้างอิงตามลำดับของ Menu BottomNavigation
  List<Widget> pages = [
    HomeFragment(),
    BookmarkFragment(),
    CategoryFragment(),
    SearchFragment(),
    ProfileFragment()
  ];

  @override
  Widget build(BuildContext context) { // BuildContext เป็นสิ่งที่ใช้สำหรับบ่งบอกตำแหน่งของ Widget บน Widget Tree
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // ชนิดของ BottomNavigationBar มี 2 แบบ 1.fixed เวลากดไอคอนจะไม่ขยับ 2. shifting จะขยับ
        selectedFontSize: 12, //ขนาด font เมื่อ select
        unselectedFontSize: 12, //ขนาด font เมื่อไม่ select
        currentIndex: selectedIndex, // ดึงหน้า Widget Screen ที่กำลังถูกเลือกอยู่

        onTap: (index) {
          //Event onTap จะคืนค่าลำดับของ Tap ที่กด แล้วส่งให้ตัวแปร selectedIndex
          selectedIndex = index;

          //คำสั่ง render widget ของหน้า
          setState(() {
            
          });
        },

        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
            activeIcon: Container( // activeIcon เมื่อไอคอนถูกเลือก
              padding: EdgeInsets.all(8.0), // padding รอบ ๆ ทั้งหมดของไอคอนตอนถูก activeIcon
              decoration: BoxDecoration( //decoration เป็น property ตกแต่ง
                shape: BoxShape.circle, // รูปร่างของ Box
                color: primaryColor.withOpacity(0.3), // ปรับสีจางตอนถูก activeIcon
              ),
              child: Icon( // ตั้งค่าไอคอนตอนถูก activeIcon
                Icons.home,
                size: 24,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Bookmark',
            icon: Icon(Icons.bookmark),
            activeIcon: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration( 
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(0.3),
              ),
              child: Icon(
                Icons.bookmark,
                size: 24,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Category',
            icon: Icon(Icons.category),
            activeIcon: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration( 
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(0.3),
              ),
              child: Icon(
                Icons.category,
                size: 24,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(Icons.search),
            activeIcon: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration( 
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(0.3),
              ),
              child: Icon(
                Icons.search,
                size: 24,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person),
            activeIcon: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration( 
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(0.3),
              ),
              child: Icon(
                Icons.person,
                size: 24,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea( //SafeArea คือ แสดงผลในพื้นที่แสดงผลได้ของโทรศัพท์
        child: pages[selectedIndex], //แสดงผลตาม pages ตำแหน่ง selectedIndex
      ),
    );
  }
}
