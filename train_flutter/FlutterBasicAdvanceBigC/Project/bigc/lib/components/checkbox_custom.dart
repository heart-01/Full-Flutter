import 'package:flutter/material.dart';

class CheckboxCustom extends StatelessWidget {
  final String name;               // name
  final double? fontSize;          // font size
  final double borderRadius;       // borderRadius Checkbox
  final bool val;                  // Value Checkbox
  final Function(bool?) onChanged; // function onChange

  const CheckboxCustom({
    Key? key,
    required this.name,
    this.fontSize,
    required this.borderRadius,
    required this.val,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(name, style: TextStyle(fontSize: fontSize)),
        SizedBox(
          height: 24.0,
          width: 24.0,
          child: Checkbox(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            value: val,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
