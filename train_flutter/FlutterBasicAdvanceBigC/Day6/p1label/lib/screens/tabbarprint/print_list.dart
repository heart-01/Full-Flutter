import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:p1label/components/elevated_full_button.dart';
import 'package:p1label/screens/tabbarprint/data_print_list.dart';
import 'package:p1label/themes/colors.dart';
import 'package:p1label/utils/constants.dart';

class PrintListScreen extends StatefulWidget {
  const PrintListScreen({Key? key}) : super(key: key);

  @override
  State<PrintListScreen> createState() => _PrintListScreenState();
}

class _PrintListScreenState extends State<PrintListScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Scrollbar(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Scrollbar(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: dataPrintList(),
                  ),
                ),
              ),
            ),
          ),

          // Button
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedFullButton(
              icon: Icons.settings_outlined,
              iconColor: white_color,
              iconSize: TEXT_SIZE_Normal,
              name: 'กำหนดเครื่องพิมพ์ กดปุ่มนี้',
              fontSize: TEXT_SIZE_SMedium,
              height: 35,
              textColor: white_color,
              btnColor: primaryColor,
              onPressed: () {
                if (kDebugMode) {
                  print('Setting');
                }
              },
            ),
          ),

          // Button Group
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: ElevatedFullButton(
                      name: 'พิมพ์',
                      icon: Icons.print_outlined,
                      iconColor: white_color,
                      iconSize: TEXT_SIZE_Medium,
                      textColor: white_color,
                      btnColor: greenColor,
                      onPressed: () {},
                      height: 30,
                      fontSize: TEXT_SIZE_SMedium,
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedFullButton(
                    name: 'ลบ',
                    icon: Icons.save_outlined,
                    iconColor: white_color,
                    iconSize: TEXT_SIZE_Medium,
                    textColor: white_color,
                    btnColor: redColor,
                    onPressed: () {},
                    height: 30,
                    fontSize: TEXT_SIZE_SMedium,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: ElevatedFullButton(
                      name: 'ออก',
                      icon: Icons.exit_to_app,
                      iconColor: white_color,
                      iconSize: TEXT_SIZE_Medium,
                      textColor: white_color,
                      btnColor: Colors.grey,
                      onPressed: () {
                        Navigator.popAndPushNamed(context, '/home');
                      },
                      height: 30,
                      fontSize: TEXT_SIZE_SMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
