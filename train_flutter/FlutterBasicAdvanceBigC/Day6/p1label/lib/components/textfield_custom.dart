// ignore_for_file: void_checks

import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  final BuildContext? context;       // context
  final TextInputType textInputType;// type input keyboard
  final bool obscureText;           // hide data
  final bool autofocus;             // auto focus
  final bool readOnly;              // readOnly data
  final String? initialValue;       // initial data
  final Function? onValidate;       // validate data
  final Function? onSaved;          // onSaved data
  final double size;                // size text box
  final Color bgColor;              // bg Color
  final Color borderColor;          // border Color
  final double borderWidth;         // border width
  final double borderRadius;        // border radius
  final double? fontSize;           // font size
  final FontWeight? fontWeight;     // font weight
  final Color? fontColor;           // font color

  const TextFieldCustom({
    Key? key,
    this.context,
    required this.textInputType,
    required this.obscureText,
    required this.autofocus,
    this.initialValue,
    this.onValidate,
    this.onSaved,
    required this.size,
    required this.bgColor,
    required this.borderColor, 
    required this.borderWidth, 
    required this.readOnly, 
    required this.borderRadius, 
    this.fontSize, 
    this.fontWeight, 
    this.fontColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      child: TextFormField(
        style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: fontColor),
        readOnly: readOnly,
        initialValue: initialValue,
        obscureText: obscureText,
        autofocus: autofocus,
        validator: (value) {
          return onValidate!(value);
        },
        onSaved: (value) {
          return onSaved!(value);
        },
        keyboardType: textInputType,
        decoration: InputDecoration(
          filled: true,
          fillColor: bgColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          ),
          isDense: true,
          contentPadding: EdgeInsets.only( left: 15, right: 15, top: size, bottom: size),
        ),
      ),
    );
  }
}