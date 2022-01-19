import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Myalert {
  static onAlertButtonsPressed(context, title, desc, onPressed) {
    return Alert(
      context: context,
      type: AlertType.warning,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
          child: Text(
            "ยืนยัน",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: onPressed,
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "ยกเลิก",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(144, 144, 144, 1.0),
            Color.fromRGBO(144, 144, 144, 1.0),
          ]),
        )
      ],
    ).show();
  }
}