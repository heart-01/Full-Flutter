import 'package:flutter/material.dart';
import 'package:smart_news/Themes/colors.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({ Key? key }) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'AboutUs',
          style: TextStyle(color: textColorSecondary),
        ),
      ),
      body: const Center(
        child: Text('Content about us'),
      ),
    );
  }
}