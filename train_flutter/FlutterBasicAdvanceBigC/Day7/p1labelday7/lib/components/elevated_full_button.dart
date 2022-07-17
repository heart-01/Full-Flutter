import 'package:flutter/material.dart';

class ElevatedFullButton extends StatelessWidget {
  final IconData? icon;      // icon
  final Color? iconColor;    // icon color
  final double? iconSize;
  final bool? closeShadow;
  final String name;         // name button
  final Color textColor;     // text name color
  final Color btnColor;       // button color
  final VoidCallback? onPressed;
  final double height;
  final double fontSize;
  final FontWeight? fontWeight;

  const ElevatedFullButton({
    Key? key,
    this.icon,
    this.iconColor,
    this.iconSize,
    this.closeShadow, 
    required this.name,
    required this.textColor,
    required this.btnColor, 
    this.onPressed, 
    required this.height, 
    required this.fontSize, 
    this.fontWeight, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        boxShadow: [
          if (closeShadow != true) BoxShadow(
            blurRadius: 5,
            offset: const Offset(0, 7),
            color: const Color.fromARGB(255, 216, 216, 216).withOpacity(1.0),
            spreadRadius: 1,
          )
        ]
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: btnColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            (icon != null && iconColor != null) ? 
              Icon(icon, color: iconColor, size: iconSize)
            : const SizedBox(width: 0),
            (icon != null && iconColor != null) ? 
              const SizedBox(width: 5)
            : const SizedBox(width: 0),
            Text(
              name,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: fontWeight
              ),
            ),
          ],
        ),
      ),
    );
  }
}