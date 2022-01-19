import 'package:flutter/material.dart';
import 'package:provi/consumer/transaction_consumer.dart';

class Home extends StatefulWidget {
  final String? title;
  Home({Key? key, this.title}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
          )
        ],
      ),
      body: TransactionConsumer.getData(),
    );
  }
}
