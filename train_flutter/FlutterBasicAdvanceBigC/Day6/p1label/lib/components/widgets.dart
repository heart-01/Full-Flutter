// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

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
      child: Image.asset('assets/images/logo/bigCLogo.png'),
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
              onPressed: (){
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

Widget btnLogout(BuildContext context) {
  return Row(
    children: [
      SizedBox(
        height: 25,
        width: 60,
        child: TextButton(
          onPressed: () {
            if (kDebugMode) {
              Navigator.pushReplacementNamed(context, '/branchcode');
            }
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(redColor),
              alignment: Alignment.topCenter,
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(Icons.exit_to_app_outlined,
                  color: white_color, size: TEXT_SIZE_SMALL),
              Text(
                "ออก",
                style: TextStyle(
                  color: white_color,
                  fontSize: TEXT_SIZE_SMALL,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
