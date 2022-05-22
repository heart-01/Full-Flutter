import 'package:bigc/screens/tabbarprint/print_list.dart';
import 'package:bigc/screens/tabbarprint/print_quick.dart';
import 'package:bigc/themes/colors.dart';
import 'package:bigc/utils/constants.dart';
import 'package:flutter/material.dart';

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
            preferredSize: const Size.fromHeight(48.0),
            child: AppBar(
              backgroundColor: secondaryColor,
              bottom: const TabBar(
                labelStyle: TextStyle(fontSize: TEXT_SIZE_LargeMedium, fontFamily: 'NotoSansThai'),
                labelColor: whiteColor,
                indicatorColor: btnLogoutColor,
                tabs: [
                  Tab(text: PRINT_QUICK),
                  Tab(text: PRINT_LIST),
                ],
              ),
            ),
          ),
    
        body: const TabBarView(
          children: [
            PrintQuickScreen(),
            PrintListScreen(),
          ],
        ),
      ),
    );
  }
}