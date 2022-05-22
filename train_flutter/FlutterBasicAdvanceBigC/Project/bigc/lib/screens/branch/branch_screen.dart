import 'package:bigc/components/elevated_full_button.dart';
import 'package:bigc/components/textfield_custom.dart';
import 'package:bigc/components/widget.dart';
import 'package:bigc/themes/colors.dart';
import 'package:bigc/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BranchScreen extends StatefulWidget {
  const BranchScreen({Key? key}) : super(key: key);

  @override
  State<BranchScreen> createState() => _BranchScreenState();
}

class _BranchScreenState extends State<BranchScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          title: appBarTitle(),
          actions: [
            btnLogout(),
          ],
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  imageHeaderWidget(image: 'assets/images/bigc.webp'),

                  // Show Data
                  Container(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0, top: 10.0),
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(2),
                      },  
                      border: TableBorder.all(color: whiteColor),
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(children: [
                          const Text("เลขที่สาขา", style: TextStyle(fontSize: TEXT_SIZE_SMALL)),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, bottom: 3),
                            child: TextFieldCustom(
                              context: context,
                              readOnly: true,
                              initialValue: '11108',
                              textInputType: TextInputType.text,
                              obscureText: false,
                              autofocus: false,
                              size: 5,
                              bgColor: inputBgColor,
                              borderColor: inputBgColor,
                              borderWidth: 1,
                              borderRadius: 10.0,
                              fontSize: TEXT_SIZE_SMALL,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),

                        TableRow(children: [
                          const Text("ชื่อสาขา", style: TextStyle(fontSize: TEXT_SIZE_SMALL)),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, bottom: 3),
                            child: TextFieldCustom(
                              context: context,
                              readOnly: true,
                              initialValue: 'HHRSC1',
                              textInputType: TextInputType.text,
                              obscureText: false,
                              autofocus: false,
                              size: 5,
                              bgColor: inputBgColor,
                              borderColor: inputBgColor,
                              borderWidth: 0,
                              borderRadius: 10.0,
                              fontSize: TEXT_SIZE_SMALL,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ]),

                        TableRow(children: [
                          const Text("ไอพี", style: TextStyle(fontSize: TEXT_SIZE_SMALL)),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, bottom: 3),
                            child: TextFieldCustom(
                              context: context,
                              readOnly: true,
                              initialValue: '192.138.43.179',
                              textInputType: TextInputType.text,
                              obscureText: false,
                              autofocus: false,
                              size: 5,
                              bgColor: inputBgColor,
                              borderColor: inputBgColor,
                              borderWidth: 0,
                              borderRadius: 10.0,
                              fontSize: TEXT_SIZE_SMALL,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ]),

                        TableRow(children: [
                          const Text("ชื่อเครื่อง", style: TextStyle(fontSize: TEXT_SIZE_SMALL)),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: TextFieldCustom(
                              context: context,
                              readOnly: true,
                              initialValue: 'MSI-291994-NB',
                              textInputType: TextInputType.text,
                              obscureText: false,
                              autofocus: false,
                              size: 5,
                              bgColor: inputBgColor,
                              borderColor: inputBgColor,
                              borderWidth: 0,
                              borderRadius: 10.0,
                              fontSize: TEXT_SIZE_SMALL,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ]),
                      ],
                    ),
                  ),

                  // Button Print
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: ElevatedFullButton(
                      name: 'Print P1 Label',
                      fontSize: TEXT_SIZE_Medium,
                      height: 35,
                      textColor: whiteColor,
                      btnColor: primaryColor,
                      onPressed: (){
                        Navigator.of(context).pushReplacementNamed('/print-screen');
                      },
                    ),
                  ),

                  // Info Update
                  infoUpdate(),

                ],
              ),
            ),
          ),
        ));
  }
}
