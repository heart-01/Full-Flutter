import 'package:flutter/material.dart';

class SearchFragment extends StatefulWidget {
  const SearchFragment({ Key? key }) : super(key: key);

  @override
  State<SearchFragment> createState() => _SearchFragmentState();
}

class _SearchFragmentState extends State<SearchFragment> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'SearchFragment',
        style: TextStyle(
          fontSize: 24,
        ),
      ),
    );
  }
}