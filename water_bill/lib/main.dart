import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_bill/Providers/theme_provider.dart';
import 'package:water_bill/Themes/app_theme.dart';
import 'package:water_bill/Utils/constant.dart';
import 'package:water_bill/routers.dart';

var initURL;
void main() {
  WidgetsFlutterBinding.ensureInitialized(); //เรียกใช้เมธอดนี้เฉพาะเมื่อคุณต้องการให้การทำอย่างอื่นก่อนเริ่มต้นที่จะเรียก runApp
  //Check the theme when opening the app.
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  initURL = '/LoginScreen';
  prefs.then((value) {
    runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (BuildContext context) {
          String? theme = value.getString(Constants.APP_THEME);
          if (theme == null || theme == "" || theme == Constants.SYSTEM_DEFAULT) {
            value.setString(Constants.APP_THEME, Constants.SYSTEM_DEFAULT);
            return ThemeNotifier(ThemeMode.system);
          }
          return ThemeNotifier(theme == Constants.DARK ? ThemeMode.dark : ThemeMode.light);
        },
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Theme Demo',
      theme: AppTheme().lightTheme,
      darkTheme: AppTheme().darkTheme,
      themeMode: themeNotifier.getThemeMode(),
      
      initialRoute: initURL,
      routes: routes,
    );
  }

}
