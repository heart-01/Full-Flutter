// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:p1label/components/IAppBar.dart';
import 'package:p1label/screens/tabbarprint/manage_print.dart';
import 'package:p1label/themes/colors.dart';

class PrintScreen extends StatefulWidget {
  const PrintScreen({Key? key}) : super(key: key);

  @override
  State<PrintScreen> createState() => _PrintScreenState();
}

class _PrintScreenState extends State<PrintScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IAppBar(
        height: 35,
        title: 'Print P1 Label',
        child: Center(
            child: Text(
            '05/06/2022',
            style: TextStyle(color: white_color,fontWeight: FontWeight.bold)
          )
        ),
      ),
      body: const ManagePrintScreen(),
    );
  }
}
