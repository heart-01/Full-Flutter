import 'package:flutter/material.dart';

class ReportFragment extends StatefulWidget {
  const ReportFragment({ Key? key }) : super(key: key);

  @override
  State<ReportFragment> createState() => _ReportFragmentState();
}

class _ReportFragmentState extends State<ReportFragment> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Report Fragment'
      ),
    );
  }
}