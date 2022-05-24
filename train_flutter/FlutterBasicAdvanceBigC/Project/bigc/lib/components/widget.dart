import 'package:bigc/components/elevated_full_button.dart';
import 'package:bigc/themes/colors.dart';
import 'package:bigc/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
          fontSize: TEXT_SIZE_LMedium,
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
        const SizedBox(height: 5),
        const Text(VERSION_APP, style: TextStyle(fontSize: TEXT_SIZE_SMedium)),
        const SizedBox(height: 10),
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

Widget btnLogout() {
  return Row(
    children: [
      SizedBox(
        height: 32,
        width: 75,
        child: TextButton(
          onPressed: (){
            if (kDebugMode) {
              print('Logout');
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(btnLogoutColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.exit_to_app_outlined,
                  color: whiteColor, size: TEXT_SIZE_Normal),
              Text(
                "ออก",
                style: TextStyle(
                  color: whiteColor,
                  fontSize: TEXT_SIZE_SMedium,
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
