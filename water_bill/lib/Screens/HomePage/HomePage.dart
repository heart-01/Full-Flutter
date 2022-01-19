import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var isDarkMode;

  @override
  Widget build(BuildContext context) {
    isDarkMode = Theme.of(context).brightness == Brightness.dark; //Check is DarkMode return true , false

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _settings(),
        ],
      ),
    );
  }

  _settings() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Align(
        alignment: Alignment.topRight,
        child: IconButton(
          icon: Icon(
            Icons.settings,
            color: Theme.of(context).accentIconTheme.color,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/SettingPage');
          },
        ),
      ),
    );
  }
}