import 'package:flutter/material.dart';
import 'package:water_bill/Utils/constant.dart';

class SettingPage extends StatefulWidget {

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  List setting = Constants.setting;
  List subSetting = Constants.subSetting;
  List linkSetting = Constants.linkSetting;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ตั้งค่า'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
        itemCount: setting.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, linkSetting[index]);
            },
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: ListTile(
                leading: Icon(Icons.color_lens_outlined, size: 39,),
                title: Text(setting[index]),
                subtitle: Text(subSetting[index]),
                trailing: Icon(Icons.arrow_right),
              ),
            ),
          );
        }
      ),
    );
  }
}