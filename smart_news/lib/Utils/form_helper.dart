import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_news/Themes/colors.dart';

class FormHelper {
  /*
  textInput Widget
  Helpper คือ การสร้าง widget เก็บไว้แล้วเรียกใช้งานได้หลายครั้งเป็นการเขียน code แบบ DRY ไม่ใช่แบบ WET
  */

  static Widget inputFieldWidget(
      BuildContext context,
      Icon icon, //Icon
      String keyName, //key ไว้รับส่งค่าของฟอร์ม
      String labelName,
      Function onValidate,
      Function onSaved,
      { //เมื่อกดปุ่ม save
      String initialValue = "",
      obscureText:
          false, //ดึงค่า password จริง ๆ ตอนกดปุ่ม submit เพราะ ตอนแรกเราจะปิด password ไว้
      Widget?
          suffixIcon //icon ทางขวามือ สามารถเป็น null ได้ ถ้าใส่ required คือ ต้องใส่ค่าเสมอ
      }) {
    return Container(
      padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
      ),
      child: TextFormField(
        initialValue: initialValue,
        key: Key(keyName), //ไว้ระบุของ Text นี้
        obscureText: obscureText,
        validator: (value) {
          return onValidate(value);
        },
        onSaved: (value) {
          return onSaved(value);
        },
        style: TextStyle(fontSize: 18.0),
        decoration: InputDecoration(
            //ตกแต่ง Input
            hintText: labelName,
            hintStyle: TextStyle(
                fontSize: 15.0,
                color: textColorSecondary,
                fontWeight: FontWeight.bold),
            enabledBorder: OutlineInputBorder(
              //enableBorder คือเมื่อโหลดแบบฟอร์มตอนแรก
              borderRadius: BorderRadius.circular(30.0),
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 1),
            ),
            border: OutlineInputBorder(
              //border คือ ตอนกดที่ input นี้
              borderRadius: BorderRadius.circular(30.0),
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 1),
            ),
            suffixIcon: suffixIcon,
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 25.0, right: 10.0),
              child: IconTheme(
                  data: IconThemeData(color: Theme.of(context).primaryColor),
                  child: icon),
            )),
      ),
    );
  }

  /* 
  * Save Button Widget
  */

  static Widget saveButton(String buttonText, Function onTap,
      {String? color, String? textColor, bool? fullWidth}) {
    return Container(
      height: 50.0,
      width: 150,
      child: GestureDetector(
        //GestureDetector เหมือนกับ tag A href เอาไปคอบอะไรสามารถกดได้
        onTap: () {
          onTap();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.redAccent,
              style: BorderStyle.solid,
              width: 1.0,
            ),
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}