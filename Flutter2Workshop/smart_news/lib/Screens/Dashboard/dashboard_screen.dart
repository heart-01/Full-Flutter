import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smart_news/Screens/Bottomnavmenu/bookmark_fragment.dart';
import 'package:smart_news/Screens/Bottomnavmenu/category_fragment.dart';
import 'package:smart_news/Screens/Bottomnavmenu/home_fragment.dart';
import 'package:smart_news/Screens/Bottomnavmenu/profile_fragment.dart';
import 'package:smart_news/Screens/Bottomnavmenu/search_fragment.dart';

import '../../Themes/colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;

  List<Widget> pages = [
    const HomeFragment(),
    const BookmarkFragment(),
    const CategoryFragment(),
    const SearchFragment(),
    const ProfileFragment()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        
        onTap: (index){
          if(kDebugMode) { // เช็คว่าเป็นโหมด dev ไหม จะแสดงการ Debug แค่ในโหมด Dev เท่านั้น
            print(index);
          }

          selectedIndex = index;

          setState(() {
            
          });
        },

        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: const Icon(Icons.home),
            activeIcon: Container( 
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(0.3),
              ),
              child: const Icon(
                Icons.home,
                size: 24,
              ),
            ),
          ),

          BottomNavigationBarItem(
            label: 'Bookmark',
            icon: const Icon(Icons.bookmark),
            activeIcon: Container( 
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(0.3),
              ),
              child: const Icon(
                Icons.bookmark,
                size: 24,
              ),
            ),
          ),

          BottomNavigationBarItem(
            label: 'Category',
            icon: const Icon(Icons.category),
            activeIcon: Container( 
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(0.3),
              ),
              child: const Icon(
                Icons.category,
                size: 24,
              ),
            ),
          ),

          BottomNavigationBarItem(
            label: 'Search',
            icon: const Icon(Icons.search),
            activeIcon: Container( 
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(0.3),
              ),
              child: const Icon(
                Icons.search,
                size: 24,
              ),
            ),
          ),

          BottomNavigationBarItem(
            label: 'Profile',
            icon: const Icon(Icons.person),
            activeIcon: Container( 
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(0.3),
              ),
              child: const Icon(
                Icons.person,
                size: 24,
              ),
            ),
          ),
        ],

      ),

      body: SafeArea(
        child: pages[selectedIndex],
      ),
    );
  }
}
