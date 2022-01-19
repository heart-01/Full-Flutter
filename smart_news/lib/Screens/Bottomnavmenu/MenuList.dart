import 'package:flutter/material.dart';
import 'package:smart_news/Themes/colors.dart';

class MenuList extends StatelessWidget {
  final IconData micon;
  final String mname;
  final Function()?
      onTap; //()? null safty //หรือ จะใช้ final VoidCallback onTap;

  MenuList(
      //Constructors ทำเมื่อเข้ามาถึง Class // required คือ การบังคับว่าจะต้องใส่ parameter
      {required this.micon,
      required this.mname,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    //context เป็น class ต้นทางในการทำ widget
    return Material(
      //Material เพิ่มคุณสมบัติ ตกแต่ง widget
      child: ListTile(
        //แยกสร้าง widget ListTile ใหม่ อยู่ใน class MenuList
        tileColor: googleColor,
        hoverColor: Colors.orange,
        leading: Icon(
          micon,
          color: Colors.white,
        ),
        title: Text(
          mname,
          style: TextStyle(color: Colors.white),
        ),
        onTap: onTap,
      ),
    );
  }
}

//แบบที่ 1
final menus = [
  MenuList(
      micon: Icons.home,
      mname: 'Home',
      onTap: () {
        print('Home tapped');
      }),
  MenuList(
      micon: Icons.new_releases,
      mname: 'Lastest news',
      onTap: () {
        print('Lastest news');
      }),
  MenuList(
      micon: Icons.category,
      mname: 'Category',
      onTap: () {
        print('Category');
      }),
  MenuList(
      micon: Icons.video_collection,
      mname: 'Video List',
      onTap: () {
        print('Video List');
      }),
  MenuList(
      micon: Icons.info,
      mname: 'About',
      onTap: () {
        print('About');
      }),
  MenuList(
      micon: Icons.logout,
      mname: 'Logout',
      onTap: () {
        print('Logout');
      }),
];
