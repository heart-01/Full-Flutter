// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:p1label/screens/tabbarprint/print_list.dart';
import 'package:p1label/screens/tabbarprint/print_quick.dart';
import 'package:p1label/themes/colors.dart';
import 'package:p1label/utils/constants.dart';

class ManagePrintScreen extends StatefulWidget {
  const ManagePrintScreen({ Key? key }) : super(key: key);

  @override
  State<ManagePrintScreen> createState() => _ManagePrintScreenState();
}

class _ManagePrintScreenState extends State<ManagePrintScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TAB_LENGTH,
      child: Scaffold(    
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(35),
            child: Container(
              height: 35,
              color: secondaryColor,
              child: TabBar(
                labelStyle: TextStyle(fontSize: TEXT_SIZE_SMedium, fontFamily: 'IBMPlexSansThaiLooped'),
                labelColor: white_color,
                indicatorColor: redColor,
                indicatorWeight: 3,
                tabs: [
                  Tab(text: PRINT_QUICK),
                  Tab(text: PRINT_LIST),
                ],
              ),
            ),
          ),
    
        body: TabBarView(
          children: [
            PrintQuickScreen(),
            PrintListScreen(),
          ],
        ),
      ),
    );
  }
}