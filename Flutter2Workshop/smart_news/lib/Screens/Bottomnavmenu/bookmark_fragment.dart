import 'package:flutter/material.dart';

class BookmarkFragment extends StatefulWidget {
  const BookmarkFragment({ Key? key }) : super(key: key);

  @override
  State<BookmarkFragment> createState() => _BookmarkFragmentState();
}

class _BookmarkFragmentState extends State<BookmarkFragment> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Bookmark',
        style: TextStyle(
          fontSize: 24,
        ),
      ),
    );
  }
}