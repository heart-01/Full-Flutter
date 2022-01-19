import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_bill/Providers/theme_provider.dart';
import 'package:water_bill/Themes/colors.dart';
import 'package:water_bill/Utils/constant.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  
  int _selectedPosition = 0;
  var isDarkTheme;
  List themes = Constants.themes;
  SharedPreferences? prefs;
  ThemeNotifier? themeNotifier;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _getSavedTheme();
    });
  }

  _getSavedTheme() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedPosition = themes.indexOf(
          prefs!.getString(Constants.APP_THEME) ?? Constants.SYSTEM_DEFAULT);
    });
  }

  @override
  Widget build(BuildContext context) {
    isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.SETTING),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemBuilder: (context, position) {
            return _createList(context, themes[position], position);
          },
          itemCount: themes.length,
        ),
      ),
    );
  }

  _createList(context, item, position) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        _updateState(position);
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Radio(
            value: _selectedPosition,
            groupValue: position,
            activeColor: isDarkTheme ? AppColors.darkPink : AppColors.textBlack,
            onChanged: (_) {
              _updateState(position);
            },
          ),
          Text(item),
        ],
      ),
    );
  }

  _updateState(int position) {
    setState(() {
      _selectedPosition = position;
    });
    onThemeChanged(themes[position]);
  }

  void onThemeChanged(String value) async {
    var prefs = await SharedPreferences.getInstance();
    if (value == Constants.SYSTEM_DEFAULT) {
      themeNotifier!.setThemeMode(ThemeMode.system);
    } else if (value == Constants.DARK) {
      themeNotifier!.setThemeMode(ThemeMode.dark);
    } else {
      themeNotifier!.setThemeMode(ThemeMode.light);
    }
    prefs.setString(Constants.APP_THEME, value);
  }
}