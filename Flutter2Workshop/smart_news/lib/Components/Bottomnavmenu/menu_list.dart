import 'package:flutter/material.dart';
import 'package:smart_news/Themes/colors.dart';

class MenuList extends StatelessWidget {
  final IconData micon;
  final String mname;
  final Function()? onTap;

  const MenuList(
      {
        Key? key, 
        required this.micon, 
        required this.mname, 
        required this.onTap
      }
  ): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        tileColor: googleColor,
        hoverColor: Colors.orange,
        leading: Icon(
          micon,
          color: Colors.white,
        ),
        title: Text(
          mname,
          style: const TextStyle(color: Colors.white),
        ),
        onTap: onTap,
      ),
    );
  }
}