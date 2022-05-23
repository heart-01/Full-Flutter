import 'package:bigc/components/elevated_full_button.dart';
import 'package:bigc/screens/tabbarprint/data_print_list.dart';
import 'package:bigc/themes/colors.dart';
import 'package:bigc/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
            height: 300,
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
            padding: const EdgeInsets.only(top: 25.0, left: 8.0, right: 8.0),
            child: ElevatedFullButton(
              icon: Icons.settings_outlined,
              iconColor: whiteColor,
              iconSize: TEXT_SIZE_Normal,
              name: 'กำหนดเครื่องพิมพ์ กดปุ่มนี้',
              fontSize: TEXT_SIZE_LMedium,
              height: 35,
              textColor: whiteColor,
              btnColor: primaryColor,
              onPressed: (){
                if (kDebugMode) {
                  print('Setting');
                }
              },
            ),
          ),
      
          // Button Group
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: ElevatedFullButton(
                      name: 'พิมพ์',
                      icon: Icons.print_outlined,
                      iconColor: whiteColor,
                      iconSize: TEXT_SIZE_Medium,
                      textColor: whiteColor,
                      btnColor: greenColor,
                      onPressed: (){},
                      height: 30,
                      fontSize: TEXT_SIZE_SMedium,
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedFullButton(
                    name: 'ลบข้อมูล',
                    icon: Icons.delete,
                    iconColor: whiteColor,
                    iconSize: 15,
                    textColor: whiteColor,
                    btnColor: Colors.red,
                    onPressed: (){},
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
                      iconColor: whiteColor,
                      iconSize: TEXT_SIZE_LargeMedium,
                      textColor: whiteColor,
                      btnColor: Colors.grey,
                      onPressed: (){},
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
