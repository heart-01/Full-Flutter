// ignore_for_file: annotate_overrides, file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:p1label/themes/colors.dart';

class IAppBar extends StatelessWidget with PreferredSizeWidget {
  //
  final Widget? child;
  final String title;
  final double height;
  final Color? color;

  IAppBar({
    Key? key,
    this.child,
    required this.title,
    this.color,
    this.height = 35,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(40),
      child: Container(
        color: color ?? primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/appicon/barcode100light.png',
                          height: 20,
                          width: 30,
                        ),
                        Text(
                          title,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: white_color,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: child,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
