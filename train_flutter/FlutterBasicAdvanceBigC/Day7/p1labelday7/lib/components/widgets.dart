// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, void_checks, prefer_equal_for_default_values

import 'package:flutter/material.dart';
import 'package:p1label/components/elevated_full_button.dart';
import 'package:p1label/themes/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:p1label/utils/constants.dart';

Widget headerWidget(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.25,
    width: MediaQuery.of(context).size.width,
    color: greenColor,
    child: Padding(
      padding: EdgeInsets.all(15.0),
      child: Image.asset('assets/images/logo/logobigc.jpg'),
    ),
  );
}

Widget footerWidget() {
  return Padding(
    padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
    child: Container(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "v.1.0.018",
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(
              height: 30,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.history,
                  size: 18.0,
                ),
                label: Text(
                  'เช็คอัพเดท',
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
            ),
          ],
        )),
  );
}

Widget imageHeaderWidget({required String image}) {
  return Container(
    width: double.infinity,
    height: 140,
    decoration: BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.fill,
        image: AssetImage(image),
      ),
    ),
  );
}

Widget appBarTitle() {
  return Row(
    children: const [
      Icon(Icons.qr_code),
      SizedBox(width: 10),
      Text(
        APP_NAME,
        style: TextStyle(
          fontSize: TEXT_SIZE_Medium,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

Widget infoUpdate() {
  return Center(
    child: Column(
      children: [
        const Text(VERSION_APP, style: TextStyle(fontSize: TEXT_SIZE_SMedium)),
        SizedBox(
          width: 121,
          child: ElevatedFullButton(
            name: TEXT_UPDATE,
            icon: Icons.update,
            iconColor: btnTextColor,
            textColor: btnTextColor,
            btnColor: btnBgVerColor,
            closeShadow: true,
            onPressed: () {
              if (kDebugMode) {
                print('Update');
              }
            },
            height: 30,
            fontSize: TEXT_SIZE_SMedium,
          ),
        )
      ],
    ),
  );
}

Widget inputFieldWidget(
    BuildContext context, 
    Icon icon, 
    String keyName,
    String hintText, 
    Function onValidate, 
    Function onSaved,
    Function onFieldSubmitted,
    {
      String initialValue = "",
      bool autofocus: false,
      bool obscureText: false,
      int maxlenght = 10,
      Widget? suffixIcon,
      var keyboardType: TextInputType.text
    }
  ) {
  return TextFormField(
    autofocus: autofocus,
    initialValue: initialValue,
    key: Key(keyName),
    obscureText: obscureText,
    validator: (val) {
      return onValidate(val);
    },
    onSaved: (val) {
      return onSaved(val.toString().trim());
    },
    onFieldSubmitted: (val){
      // print(val);
      return onFieldSubmitted(val.toString().trim());
    },
    style: TextStyle(
      fontSize: 18.0,
    ),
    maxLength: maxlenght,
    cursorColor: textColorPrimary,
    keyboardType: keyboardType,
    decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14.0, color: textColorSecondary),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        errorStyle: TextStyle(fontSize: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: blueColor, width: 1),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: blueColor, width: 1),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: IconTheme(data: IconThemeData(color: blueColor), child: icon),
        )),
  );
}

/*
* Submit Button Widget
*/
Widget submitButton(
  String buttonText,
  Function() onPress, {
  String? color,
  String? textColor,
  bool? fullWidth,
}) {
  return SizedBox(
    width: double.infinity,
    height: 40,
    child: ElevatedButton(
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 18),
      ),
      onPressed: onPress,
    ),
  );
}
