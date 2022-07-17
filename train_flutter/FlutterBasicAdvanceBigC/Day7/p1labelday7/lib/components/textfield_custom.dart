// ignore_for_file: void_checks

import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  final BuildContext? context;      // context
  final TextInputType textInputType;// type input keyboard
  final bool obscureText;           // hide data
  final bool autofocus;             // auto focus
  final bool readOnly;              // readOnly data
  final String? initialValue;       // initial data
  final Function? onValidate;       // validate data
  final Function? onSaved;          // onSaved data
  final Function? onFieldSubmitted; // Submit field         
  final double size;                // size text box
  final Color bgColor;              // bg Color
  final Color borderColor;          // border Color
  final double borderWidth;         // border width
  final double borderRadius;        // border radius
  final double? fontSize;           // font size
  final FontWeight? fontWeight;     // font weight
  final Color? fontColor;           // font color
  final int? maxLength;             // max length

  const TextFieldCustom({
    Key? key,
    this.context,
    required this.textInputType,
    required this.obscureText,
    required this.autofocus,
    this.initialValue,
    this.onValidate,
    this.onSaved,
    this.onFieldSubmitted,
    required this.size,
    required this.bgColor,
    required this.borderColor, 
    required this.borderWidth, 
    required this.readOnly, 
    required this.borderRadius, 
    this.fontSize, 
    this.fontWeight, 
    this.fontColor,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      child: TextFormField(
        key: key,
        focusNode: FocusNode(),
        style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: fontColor),
        readOnly: readOnly,
        initialValue: initialValue,
        obscureText: obscureText,
        autofocus: autofocus,
        maxLength: maxLength,
        validator: (value) {
          return onValidate!(value);
        },
        onSaved: (value) {
          return onSaved!(value);
        },
        onFieldSubmitted: (value){
          return onFieldSubmitted!(value);
        },
        keyboardType: textInputType,
        decoration: InputDecoration(
          filled: true,
          fillColor: bgColor,
          counterText: '',
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