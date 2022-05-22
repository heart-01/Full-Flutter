import 'package:flutter/material.dart';
import 'package:smart_news/Themes/colors.dart';

class VideoListScreen extends StatefulWidget {
  const VideoListScreen({ Key? key }) : super(key: key);

  @override
  State<VideoListScreen> createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Video List',
          style: TextStyle(color: textColorSecondary),
        ),
      ),
      body: const Center(
        child: Text('Content VDO List'),
      ),
    );
  }
}