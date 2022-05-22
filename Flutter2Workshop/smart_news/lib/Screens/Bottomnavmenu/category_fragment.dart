import 'package:flutter/material.dart';

class CategoryFragment extends StatefulWidget {
  const CategoryFragment({ Key? key }) : super(key: key);

  @override
  State<CategoryFragment> createState() => _CategoryFragmentState();
}

class _CategoryFragmentState extends State<CategoryFragment> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Category',
        style: TextStyle(
          fontSize: 24,
        ),
      ),
    );
  }
}