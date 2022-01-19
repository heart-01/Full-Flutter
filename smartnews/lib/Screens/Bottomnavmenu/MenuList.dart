import 'package:flutter/material.dart';
import 'package:smart_news/Themes/colors.dart';

class MenuList extends StatelessWidget {

  final IconData micon;
  final String mname;
  // final Function()? onTap;
  final VoidCallback onTap;

  MenuList(
    {
      required this.micon, 
      required this.mname, 
      required this.onTap
    }
  ); 

  @override
  Widget build(BuildContext context){
    return Material(
      child: ListTile(
        tileColor: googleColor,
        hoverColor: Colors.orange,
        leading: Icon(micon, color: Colors.white,),
        title: Text(mname, style: TextStyle(color: Colors.white),),
        onTap: onTap,
      ),
    );
  }

}

final menus = [
    MenuList(micon: Icons.home, mname: 'Home', onTap: (){ print('Home tapped');}),
    MenuList(micon: Icons.new_releases, mname: 'Lastest news', onTap: (){ print('Lastest news tapped');}),
    MenuList(micon: Icons.category, mname: 'Category', onTap: (){ print('Category tapped');}),
    MenuList(micon: Icons.video_collection, mname: 'Video List', onTap: (){ print('Video List tapped');}),
    MenuList(micon: Icons.info, mname: 'About', onTap: (){ print('About tapped');}),
    MenuList(micon: Icons.logout, mname: 'Logout', onTap: (){ print('Logout tapped');}),
];