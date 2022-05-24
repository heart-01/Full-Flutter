// ignore_for_file: prefer_const_constructors_in_immutables, avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:p1label/components/IAppBar.dart';
import 'package:p1label/components/form_helper.dart';
import 'package:p1label/components/textfield_custom.dart';
import 'package:p1label/components/widgets.dart';
import 'package:p1label/themes/colors.dart';
import 'package:p1label/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IAppBar(
        height: 35,
        title: 'Print P1 Label',
        child: btnLogout(context),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              child: Column(
                children: [
                  headerWidget(context),
                  Expanded(
                      // Show Data
                      child: Container(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10.0),
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(2),
                      },
                      border: TableBorder.all(color: white_color),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(children: [
                          const Text("เลขที่สาขา",
                              style: TextStyle(fontSize: TEXT_SIZE_SMALL)),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3),
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
                              borderRadius: 5.0,
                              fontSize: TEXT_SIZE_SMALL,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          const Text("ชื่อสาขา",
                              style: TextStyle(fontSize: TEXT_SIZE_SMALL)),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3),
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
                              borderRadius: 5.0,
                              fontSize: TEXT_SIZE_SMALL,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ]),
                        TableRow(children: [
                          const Text("ไอพี",
                              style: TextStyle(fontSize: TEXT_SIZE_SMALL)),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3),
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
                              borderRadius: 5.0,
                              fontSize: TEXT_SIZE_SMALL,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ]),
                        TableRow(children: [
                          const Text("ชื่อเครื่อง",
                              style: TextStyle(fontSize: TEXT_SIZE_SMALL)),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3),
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
                              borderRadius: 5.0,
                              fontSize: TEXT_SIZE_SMALL,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ]),
                      ],
                    ),
                  )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: FormHelper.submitButton("Print P1 Label", () async {
                      Navigator.pushReplacementNamed(context, '/print-screen');
                    }),
                  ),
                  SizedBox(height: 20,),
                  footerWidget()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
