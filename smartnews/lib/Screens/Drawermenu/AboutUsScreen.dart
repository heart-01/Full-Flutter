import 'package:flutter/material.dart';
import 'package:smart_news/Themes/colors.dart';

class AboutUsScreen extends StatefulWidget {
  AboutUsScreen({Key? key}) : super(key: key);

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('About us', style: TextStyle(color: textColorSecondary),),
      ),
      body: Center(
        child: Text('About US'),
      ),
    );
  }
}