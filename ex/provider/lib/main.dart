import 'package:flutter/material.dart';
import 'package:provi/providers/transaction_provider.dart';
import 'package:provi/routers.dart';
import 'package:provider/provider.dart';

import 'screen/home.dart';

var initURL;
main(List<String> args) {
  initURL = '/Home';
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider( //เรียกใช้ MultiProvider ในการเชื่อม providers ต่าง ๆ ที่ต้องการเรียกใช้
      providers: [ //ใส่ชื่อ provider 
        ChangeNotifierProvider(create: (context){ //รอรับฟังว่า provider TransactionProvider มีการ update เปลี่ยนแปลงข้อมูลอะไรบ้าง 
                                                  //พอมีมีการเปลี่ยนแปลงค่าข้อมูลก็จะให้ consumer รับค่าข้อมูลการเปลี่ยนแปลงข้อมูลส่วนนั้น และ Render Widget ออกมา และนำข้อมูลส่วนนั้นไปแปะบนส่วนที่เราต้องการ
          return TransactionProvider();
        }),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Home(
          title: 'แอพบัญชี',
        ),
        
        routes: routes, //เชื่อม routes กับ main
      ),
    );
  }
}
