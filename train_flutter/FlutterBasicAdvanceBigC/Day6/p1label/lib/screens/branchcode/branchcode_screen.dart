// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:p1label/components/IAppBar.dart';
import 'package:p1label/components/form_helper.dart';
import 'package:p1label/components/widgets.dart';
import 'package:p1label/themes/colors.dart';

class BranchCodeScreen extends StatefulWidget {
  BranchCodeScreen({Key? key}) : super(key: key);

  @override
  State<BranchCodeScreen> createState() => _BranchCodeScreenState();
}

class _BranchCodeScreenState extends State<BranchCodeScreen> {

  // สร้างตัวแปรสำหรับไว้ผูกกับฟอร์ม
  final formKey = GlobalKey<FormState>();

  // สร้างตัวแปรไว้รับค่าจากฟอร์ม
  late String _branchcode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IAppBar(
        height: 35,
        title: 'Print P1 Label',
        child: Container(),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                  child: Column(
                children: [
                  headerWidget(context),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('กรุณาใส่รหัสสาขา'),
                              SizedBox(
                                height: 5,
                              ),
                              FormHelper.inputFieldWidget(
                                  context,
                                  const Icon(Icons.store_outlined),
                                  "branchcode",
                                  "ป้อนรหัสสาขา 5 หลัก", (onValidateVal) {
                                if (onValidateVal.isEmpty) {
                                  return 'ป้อนรหัสสาขาก่อน';
                                }else if(onValidateVal.length < 5){
                                  return 'รหัสสาขาต้องไม่น้อยกว่า 5 ตัวอักษร';
                                }
                                return null;
                              }, (onSavedVal) {
                                _branchcode = onSavedVal;
                              },
                                  keyboardType: TextInputType.number),
                              const SizedBox(
                                height: 10,
                              ),
                              FormHelper.submitButton("ตกลง", () async {

                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  print(_branchcode);

                                  Navigator.pushReplacementNamed(context, '/home');
                                }

                              }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  footerWidget()
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
