import 'package:flutter/material.dart';
import 'package:smart_news/Themes/colors.dart';

class LatestNewsListScreen extends StatefulWidget {
  const LatestNewsListScreen({ Key? key }) : super(key: key);

  @override
  State<LatestNewsListScreen> createState() => _LatestNewsListScreenState();
}

class _LatestNewsListScreenState extends State<LatestNewsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Latest News',
          style: TextStyle(color: textColorSecondary),
        ),
      ),
      body: const Center(
        child: Text('Content lastest news'),
      ),
    );
  }
}