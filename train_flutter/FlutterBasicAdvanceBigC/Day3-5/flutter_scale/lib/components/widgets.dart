// ignore_for_file: void_checks, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_scale/themes/colors.dart';

/* 
* textInput Widget แบบสร้าง widgets แยก
*/
Widget inputFieldWidget(
    // Parameter required
    BuildContext context,
    Icon icon,
    String keyName,
    String labelText,
    String hintText,
    Function onValidate,
    Function onSaved, 
    {
      // Parameter optional 
      String initialValue = "",
      bool autofocus: false,
      bool obscureText: false,
      Widget? suffixIcon,
      var keyboardType: TextInputType.text
    }
  ){
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
      style: TextStyle(
        fontSize: 18.0,
      ),
      cursorColor: blueColor,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: 16.0,
              color: textColorSecondary
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          errorStyle: TextStyle(fontSize: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide:
                BorderSide(color: blueColor, width: 1),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide:
                BorderSide(color: blueColor, width: 1),
          ),
          suffixIcon: suffixIcon,
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: IconTheme(
                data: IconThemeData(color: blueColor),
                child: icon),
          )),
    );
  }

  /*
  * Submit Button Widget แบบสร้าง widgets แยก
  */
Widget submitButton(
    String buttonText, 
    Function() onPress,
    {
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