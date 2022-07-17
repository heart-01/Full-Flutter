// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:ota_update/ota_update.dart';
import 'package:p1label/components/IAppBar.dart';
import 'package:p1label/components/widgets.dart';
import 'package:p1label/helper/shared_pref.dart';
import 'package:p1label/models/app_language.dart';
import 'package:p1label/provider/app_locale.dart';
import 'package:p1label/themes/colors.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// แสดงภาษาต่าง ๆ จะ import ในหน้าที่จะใช้งานการเปลี่ยนภาษา
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BranchCodeScreen extends StatefulWidget {
  BranchCodeScreen({Key? key}) : super(key: key);

  @override
  State<BranchCodeScreen> createState() => _BranchCodeScreenState();
}

class _BranchCodeScreenState extends State<BranchCodeScreen> {
  // สร้าง Object sharedprefference
  late SharedPreferences sharedPreferences;

  // สร้างตัวแปรสำหรับไว้ผูกกับฟอร์ม
  final formKey = GlobalKey<FormState>();

  // สร้างตัวแปรชื่อสาขาไว้รับค่าจากฟอร์ม
  late String _branchcode;

  // ตัวแปรเก็บชื่อสาขาจาก API
  final String branchName = "HHRSC1";

  // สร้าง Object Network Info สำหรับอ่านข้อมูลการเชื่อมต่อ Network เช่น IP, Macaddress จาก package
  final info = NetworkInfo();

  // สร้าง Object Device Info สำหรับอ่านรายละเอียดอุปกรณ์ จาก package
  /* เพิ่ม permission ในไฟล์ AndroidManifest.xml
  <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
  <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" /> */
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  // สร้างฟังก์ชันการ submitBranch
  void submitBranch() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      print(_branchcode);

      // สร้างตัวแปรเก็บ ip address
      var _wifiIP = await info.getWifiIP();
      print(_wifiIP); // print IP

      // สร้างตัวแปรเก็บชื่อ Device
      AndroidDeviceInfo _androidInfo = await deviceInfo.androidInfo;
      print(_androidInfo.model); // print รุ่นอุปกรณ์ Android

      // เก็บข้อมูลใน localstorage นำไปใช้ในหน้า home
      sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setInt('userStep', 1); // ข้อมูล userStep
      sharedPreferences.setString('branchCode', _branchcode);
      sharedPreferences.setString('branchName', branchName);
      sharedPreferences.setString('ipAddress', _wifiIP.toString());
      sharedPreferences.setString('modelAndroid', _androidInfo.model.toString());
      
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  // ---------------------------------------------------------------------------------------
  // เปลี่ยนภาษา
  late AppLanguage dropdownValueLanguage; // สร้างตัวแปรไว้เก็บข้อมูลใน drop downlist 
  late String currentDefaultSystemLocale; // เก็บตัวภาษาของระบบ
  int selectedLangIndex = 0; // ตัวแปรไว้ selected ใน DropdownValue ของ DropdownBox เมื่อกลับมายังแอปอีกครั้ง
  late AppLocale _appLocal; // object _appLocal ของ Class AppLocale

  void _setFlag(){
    //รับตัวภาษาของระบบก่อนว่าเป็นภาษาอะไรจะได้ค่าเป็น th_TH แล้ว split เอาแค่ th เพื่อไป selected ที่ dropdown
    currentDefaultSystemLocale = _appLocal.proviLocale.languageCode.split('_')[0]; 
    setState(() {
      // ส่ง currentDefaultSystemLocale เข้าไปใน function เพื่อไปดึงตำแหน่ง index ของ Dropdown
      selectedLangIndex = _getLangIndex(currentDefaultSystemLocale); 
    });
  }

  // function get index ของภาษาใน Dropdown เพราะ จะเอาไปเลือกใน Dropdown ต่อ
  int _getLangIndex(String currentDefaultSystemLocale){ 
    int _langIndex = 0;
    switch(currentDefaultSystemLocale){
      case 'en' : _langIndex = 0; break;
      case 'th' : _langIndex = 1; break;
      case 'lo' : _langIndex = 2; break;
    }
    return _langIndex;
  }

  @override
  void didChangeDependencies() {   // 
    super.didChangeDependencies();
    _appLocal = Provider.of<AppLocale>(context);  // เรียกใช้ Provider
    // เรียกใช้ get ตัวแปร SharedPreferences 
    getLocale().then((prefLocale) { 
      _appLocal.changeLocale(Locale(prefLocale.languageCode));
      dropdownValueLanguage = AppLanguage.languages().firstWhere(
        (element) => element.languageCode == prefLocale.languageCode
      );
      _setFlag();
    });
  }
  // ---------------------------------------------------------------------------------------
  // อัพเดตแอพ

  // สร้าง Method อ่าน Version และ build number ของแอพ
  String? app_version, app_build_number;
  void getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // print(packageInfo.packageName);
    // print(packageInfo.version);
    // print(packageInfo.buildNumber);
    setState(() {
      app_version = packageInfo.version;
      app_build_number = packageInfo.buildNumber;
    });

    // เก็บข้อมูล version และ buildNumber ลงใน localstorage
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('version', app_version!);
    sharedPreferences.setString('buildNumber', app_build_number!);
  }

  // สร้างฟังชั่นเช็คอัพเดตแอพ
  late OtaEvent currentEvent;
  Future<void> checkUpdateApp() async {
    print(int.parse(app_build_number!));
    // เช็คว่า build number มากกว่า 1 ตรงนี้ปกติต้องดึงค่าจาก api มาแล้วเช็คว่า version ของ app มีการอัพเดตไหมแล้วค่อยอัพเดตแอพถ้าเลข app_build_number ไม่ตรงกับ app ที่ใช้งานอยู่
    if(int.parse(app_build_number!) > 0)
    {

      try {
        OtaUpdate()
          .execute('https://itgenius.co.th/sandbox_api/apk/heartV2.apk', // link ที่อยู่ app update
          destinationFilename: 'heartV2.apk',
        )
        .listen(
          (OtaEvent event) {
            setState(() => currentEvent = event);
          },
        );
      } catch (e) {
        print('Failed to make OTA update. Details: $e');
      }
      
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: dartGreenColor,
        content: Text('เป็นเวอร์ชั่นล่าสุดแล้ว', textAlign: TextAlign.center,)
      ));
    }
  }

  // ---------------------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    // เรียกใช้ method languages ใน Class AppLanguage แล้วดึง List ค่าแรกมาใช้งานเพื่อเป็นค่าเริ่มต้น
    dropdownValueLanguage = AppLanguage.languages().first; 

    getAppVersion(); // เรียกใช้ function อ่านข้อมูลแอพ
  }

  @override
  Widget build(BuildContext context) {

    // Close Keyboard
    // Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
    
    return Scaffold(
      // ตัวเปลี่ยนภาษา
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
          child: Image.asset('assets/images/appicon/barcode100light.png'),
        ),
        titleSpacing: 0,
        title: Text(AppLocalizations.of(context)!.app_title),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top:16.0),
            child: Text(AppLocalizations.of(context)!.changelang),
          ),
          SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),

            // Dropdown Language
            child: DropdownButton<AppLanguage>( // เลือก dropdown โดยใช้ Class Model AppLanguage เป็น value
              dropdownColor: primaryColor,
              iconEnabledColor: white_color,
              underline: Container( height: 0, color: yellowColor, ),
              value: dropdownValueLanguage,
              items:  AppLanguage.languages()  // loop ดึง value และ text ของ dropdown
                      .map<DropdownMenuItem<AppLanguage>>(
                        (e) => DropdownMenuItem<AppLanguage>(
                          value: e,
                          child: Text(e.name, style: TextStyle(color: white_color)),
                        )
                      ).toList(),
              onChanged: (AppLanguage? language){ // callback เมื่อมีการเลือกภาษาให้ดึง object language ในตอนแลือก
                dropdownValueLanguage = language!; // ส่งค่าที่เลือกใน dropdown ลงในตัวแปร dropdownValueLanguage
                _appLocal.changeLocale(Locale(language.languageCode));

                _setFlag();
                setLocale(language.languageCode); // set ตัวแปร SharedPreferences selectedLang ให้เป็น value ตาม dropdown
                inspect(dropdownValueLanguage); // แสดงการเลือก dropdown
              }
            ),
          ),
        ],
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
                            inputFieldWidget(
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
                            (onFieldSubmittedVal) {
                              submitBranch();
                            },
                            keyboardType: TextInputType.number,
                            autofocus: true,
                            maxlenght: 5,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            submitButton("ตกลง", () {
                              submitBranch();
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // footerWidget()
                // Button And Text Update
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                  child: Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'v.' + (app_version ?? "...") + '+' + (app_build_number ?? "..."),
                            style: TextStyle(fontSize: 14.0),
                          ),
                          SizedBox(
                            height: 30,
                            child: OutlinedButton.icon(
                              onPressed: checkUpdateApp,
                              icon: Icon(
                                Icons.history,
                                size: 18.0,
                              ),
                              label: Text(
                                'เช็คอัพเดทSSS',
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),

              ],
            )),
          )
        ],
      ),
    );
  }
}
