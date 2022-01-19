import 'package:flutter/material.dart';

class ProfileFragment extends StatefulWidget {
  @override
  _ProfileFragmentState createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  @override
  Widget build(BuildContext context) {
    return Center(
       child: Text('Profile', style: TextStyle(fontSize: 24),),
    );
  }
}