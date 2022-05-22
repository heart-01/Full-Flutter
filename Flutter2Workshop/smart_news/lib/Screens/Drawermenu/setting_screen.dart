import 'package:flutter/material.dart';
import 'package:smart_news/Themes/colors.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({ Key? key }) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Setting',
          style: TextStyle(color: textColorSecondary),
        ),
      ),
      body: const Center(
        child: Text('Content Setting Screen'),
      ),
    );
  }
}