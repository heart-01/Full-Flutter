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

  int selectedIndex = 0;

  List<Widget> pages = [
    HomeFragment(),
    BookmarkFragment(),
    CategoryFragment(),
    SearchFragment(),
    ProfileFragment()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: textColorSecondary,
              blurRadius: 3,
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          onTap: (index){
            selectedIndex = index;
            // คำสั่งในการ render ui
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
              activeIcon: Container(
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor.withOpacity(0.2),
                ),
                child: Icon(Icons.home, size: 24,),
              )
            ),
            BottomNavigationBarItem(
              label: 'Bookmark',
              icon: Icon(Icons.bookmark),
              activeIcon: Container(
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor.withOpacity(0.2),
                ),
                child: Icon(Icons.bookmark, size: 24,),
              )
            ),
            BottomNavigationBarItem(
              label: 'Category',
              icon: Icon(Icons.category),
              activeIcon: Container(
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor.withOpacity(0.2),
                ),
                child: Icon(Icons.category, size: 24,),
              )
            ),
            BottomNavigationBarItem(
              label: 'Search',
              icon: Icon(Icons.search),
              activeIcon: Container(
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor.withOpacity(0.2),
                ),
                child: Icon(Icons.search, size: 24,),
              )
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(Icons.person),
              activeIcon: Container(
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor.withOpacity(0.2),
                ),
                child: Icon(Icons.person, size: 24,),
              )
            ),
          ]
        ),
      ),
      body: SafeArea(
        child: pages[selectedIndex]
      ),
    );
  }
}