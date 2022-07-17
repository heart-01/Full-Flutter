import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provi/consumer/transaction_consumer.dart';
import 'package:provi/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final String? title;
  Home({Key? key, this.title}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<TransactionProvider>(context, listen: false).initData(); // of<ให้ระบุชื่อ Provider ที่เราต้องการให้ทำงาน>  listen:false คือ กำหนดให้ยังไม่มีคำขอหรือยังไม่มีการแจ้งเตือนอะไรไป
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/FormScreen');
            },
            icon: Icon(Icons.add),
          ),
          
          IconButton( //ปุ่มออกจาก App
            onPressed: () {
              SystemNavigator.pop();
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: TransactionConsumer.getData(),
    );
  }
}
