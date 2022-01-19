import 'package:flutter/material.dart';
import 'package:smart_news/Themes/colors.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Setting',
          style: TextStyle(color: textColorSecondary),
        ),
      ),
      body: Center(
        child: Text('content Setting'),
      ),
    );
  }
}