import 'package:bigc/components/widget.dart';
import 'package:bigc/screens/tabbarprint/manage_print.dart';
import 'package:flutter/material.dart';

class PrintScreen extends StatefulWidget {
  const PrintScreen({ Key? key }) : super(key: key);

  @override
  State<PrintScreen> createState() => _PrintScreenState();
}

class _PrintScreenState extends State<PrintScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 40,
          title: appBarTitle(),
          actions: const [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(child: Text('05/01/2020', style: TextStyle(fontWeight: FontWeight.bold))),
            ),
          ],
        ),
      body: const ManagePrintScreen(),
    );
  }
}