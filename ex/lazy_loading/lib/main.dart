import 'package:flutter/material.dart';
import 'package:lazy_loading/InfiniteImage.dart';

void main()=> runApp(LazyLoadFlutter());

class LazyLoadFlutter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Lazy Load Flutter",
      home: InfiniteImage(),
    );
  }
}