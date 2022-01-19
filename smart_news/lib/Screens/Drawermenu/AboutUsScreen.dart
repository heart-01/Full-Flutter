import 'package:flutter/material.dart';
import 'package:smart_news/Themes/colors.dart';

class AboutUsScreen extends StatefulWidget {
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
        title: Text(
          'AboutUs',
          style: TextStyle(color: textColorSecondary),
        ),
      ),
      body: Center(
        child: Text('content AboutUs'),
      ),
    );
  }
}
