import 'package:bigc/components/elevated_full_button.dart';
import 'package:bigc/components/textfield_custom.dart';
import 'package:bigc/components/widget.dart';
import 'package:bigc/themes/colors.dart';
import 'package:bigc/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  final formKey = GlobalKey<FormState>();
  String branchCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        title: appBarTitle(),
      ),
      body: GestureDetector(
        onTap: () {          
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  imageHeaderWidget(image: 'assets/images/bigc.webp'),
                  
                  // textField
                  const Padding(
                    padding: EdgeInsets.only(left: 20, top: 12),
                    child: Text("กรุณาใส่รหัสสาขา", style: TextStyle(fontSize: TEXT_SIZE_LargeMedium, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 8, right: 20),
                    child: TextFieldCustom(
                      context: context,
                      readOnly: false,
                      initialValue: '11108',
                      textInputType: TextInputType.text,
                      obscureText: false,
                      autofocus: false,
                      size: 10,
                      bgColor: whiteColor,
                      borderColor: primaryColor,
                      borderWidth: 2,
                      borderRadius: 10.0,
                      fontWeight: FontWeight.bold,
                      onValidate: (data){
                        if (data.isEmpty) {
                          return 'กรุณาใส่รหัสสาขา';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        branchCode = value.toString().trim();
                        
                      },
                    ),
                  ),

                  // Button Confirm
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 50),
                    child: ElevatedFullButton(
                      name: 'ตกลง',
                      fontSize: TEXT_SIZE_LargeMedium,
                      fontWeight: FontWeight.bold,
                      height: 50,
                      textColor: whiteColor,
                      btnColor: primaryColor,
                      onPressed: (){
                        if(formKey.currentState!.validate()){
                          formKey.currentState!.save();  
                          if (kDebugMode) {
                            print("รหัสสาขา: $branchCode");
                          }
                          
                          // Navigator.of(context).pushReplacementNamed('/branch');
                          Navigator.of(context).pushReplacementNamed('/branch');
                        }
                      },
                    ),
                  ),

                  // Info Update
                  infoUpdate(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
