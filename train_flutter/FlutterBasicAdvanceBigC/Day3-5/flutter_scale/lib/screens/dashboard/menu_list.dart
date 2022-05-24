import 'package:flutter/material.dart';

class MenuList extends StatelessWidget {
  // Property
  final IconData micon; // final ใช้ภายใน class นี้
  final Color? miconColor;
  final String mname;
  final Color? mtextColor;
  final VoidCallback? onTap;
  final Color? mtitleColor;

  // Constructor
  const MenuList({
    Key? key, 
    required this.micon, 
    required this.mname, 
    this.miconColor, 
    this.mtextColor, 
    this.mtitleColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        micon,
        size: 20,
        color: (miconColor == null) ? Colors.white : miconColor ,
      ),
      tileColor: mtitleColor, 
      title: Text(mname, style: TextStyle( color:  mtextColor, fontSize: 16 ),),
      minLeadingWidth: 0,
      horizontalTitleGap: 5,
      visualDensity: const VisualDensity(vertical: 1), // เว้นช่องไฟระหว่างเมนู
      dense: true,
      onTap: onTap,
    );
  }
}
