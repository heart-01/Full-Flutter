import 'package:bigc/components/elevated_full_button.dart';
import 'package:bigc/screens/tabbarprint/data_print_quick.dart';
import 'package:bigc/themes/colors.dart';
import 'package:bigc/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PrintQuickScreen extends StatefulWidget {
  const PrintQuickScreen({Key? key}) : super(key: key);

  @override
  State<PrintQuickScreen> createState() => _PrintQuickScreenState();
}

class _PrintQuickScreenState extends State<PrintQuickScreen> {
  bool ckSF = false;
  bool ckBS = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {          
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                dataPrintQuick(
                  ckSF: ckSF,
                  onChangedSF: (val) {
                    setState(() {
                      ckSF = val!;
                      if (kDebugMode) {
                        print('Check SF: $ckSF');
                      }
                    });
                  },
                  ckBS: ckBS,
                  onChangedBS: (val) {
                    setState(() {
                      ckBS = val!;
                      if (kDebugMode) {
                        print('Check BS: $ckBS');
                      }
                    });
                  },
                ),
      
                // Button
                Padding(
                  padding: const EdgeInsets.only(top: 35.0, bottom: 8.0),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: ElevatedFullButton(
                          name: 'พิมพ์',
                          icon: Icons.print_outlined,
                          iconColor: whiteColor,
                          iconSize: TEXT_SIZE_LargeMedium,
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
                        name: 'จัดเก็บ',
                        icon: Icons.save_outlined,
                        iconColor: whiteColor,
                        iconSize: TEXT_SIZE_LargeMedium,
                        textColor: whiteColor,
                        btnColor: Colors.purple,
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
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
