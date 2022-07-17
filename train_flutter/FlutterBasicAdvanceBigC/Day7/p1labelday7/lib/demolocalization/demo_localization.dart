import 'package:flutter/material.dart';

// แสดงภาษาต่าง ๆ จะ import ในหน้าที่จะใช้งานการเปลี่ยนภาษา
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DemoLocalizationScreen extends StatefulWidget {
  const DemoLocalizationScreen({ Key? key }) : super(key: key);

  @override
  State<DemoLocalizationScreen> createState() => _DemoLocalizationScreenState();
}

class _DemoLocalizationScreenState extends State<DemoLocalizationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Localization'),
      ),
      body: Center(
        child: Text(AppLocalizations.of(context)!.error_branchtext), // เรียกใช้งานตัวแปร hello ที่อยู่ในไฟล์ .arb จะเปลี่ยนไปตามภาษาของเครื่อง
      ),
    );
  }
}