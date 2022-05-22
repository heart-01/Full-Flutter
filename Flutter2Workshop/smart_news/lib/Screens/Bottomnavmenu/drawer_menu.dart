import 'package:flutter/material.dart';
import 'package:smart_news/Components/Bottomnavmenu/menu_list.dart';
import 'package:smart_news/Themes/colors.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // User Info
          const UserAccountsDrawerHeader(
            accountName: Text('Siwat Jermwatthana'),
            accountEmail: Text('siwat@email.com'),
            currentAccountPicture: CircleAvatar(
                // backgroundImage: AssetImage('assets/images/avatar.jpg'),
            ),
            decoration: BoxDecoration(color: googleColor),
          ),

          // List Menu
          MenuList(
            micon: Icons.new_releases,
            mname: 'Lastest news',
            onTap: () {
              Navigator.pushNamed(context, '/lastest_news');
            },
          ),
          MenuList(
            micon: Icons.category,
            mname: 'Category',
            onTap: () {
              Navigator.pushNamed(context, '/category');
            },
          ),
          MenuList(
            micon: Icons.video_collection,
            mname: 'Video List',
            onTap: () {
              Navigator.pushNamed(context, '/videolist');
            },
          ),
          MenuList(
            micon: Icons.info,
            mname: 'About',
            onTap: () {
              Navigator.pushNamed(context, '/about');
            },
          ),
          MenuList(
            micon: Icons.settings,
            mname: 'Setting',
            onTap: () {
              Navigator.pushNamed(context, '/setting');
            },
          ),
          MenuList(
            micon: Icons.logout,
            mname: 'Logout',
            onTap: () {
              Navigator.pushNamed(context, '/setting');
            },
          ),
        ],
      ),
    );
  }
}
