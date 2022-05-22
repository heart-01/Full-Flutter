import 'package:flutter/material.dart';
import 'package:smart_news/Themes/colors.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({ Key? key }) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Category',
          style: TextStyle(color: textColorSecondary),
        ),
      ),
      body: const Center(
        child: Text('Category Screen'),
      ),
    );
  }
}