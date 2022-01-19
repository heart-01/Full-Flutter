import 'package:flutter/material.dart';
import 'package:smart_news/Themes/colors.dart';

class LatestNewsListScreen extends StatefulWidget {
  @override
  _LatestNewsListScreenState createState() => _LatestNewsListScreenState();
}

class _LatestNewsListScreenState extends State<LatestNewsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Lastest News', style: TextStyle(color: textColorSecondary),),
      ),
      body: Center(
        child: Text('Content lastest news'),
      ),
    );
  }
}