import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provi/models/Transaction.dart';
import 'package:provi/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

class TransactionConsumer {

  static Widget getData() {
    return Consumer( //consumer รับข้อมูล และนำข้อมูลที่รับมาจาก TransactionProvider มาใช้งาน 
        builder: (context, TransactionProvider provider, Widget? child) { //เมื่อ consumer รับข้อมูลมา builder จะบอกว่าให้ทำอะไร รับค่าเป็น 1.context พื้นที่การทำงานในหน้านี้ 2.ชื่อของ provider 3.ชื่อของ widget
          //สิ่งที่ต้องแสดงผลใน builder คือ widget

          var count = provider.transactions.length; //provider.transactions.length นับจำนวนที่ TransactionProvider มีอยู่

          return (count <= 0 ) 
          ? Center(
            child: Text('ไม่พบข้อมูล', style: TextStyle(fontSize: 35),),
          )
          : ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 5), //symmetric กำหนดระยะห่างจากด้าน บน และ ข้าง
            itemCount: count,
            itemBuilder: (context, index) {
              Transaction data = provider.transactions[index]; //data เป็นตัวแปรแบบ Object Model Class Transaction โดยดึงค่าจาก list TransactionProvider ทีละแถว
              return Card(
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: FittedBox(
                      child: Text(data.amount!),
                    ),
                  ),
                  title: Text(data.title!),
                  subtitle: Text(DateFormat("dd/MM/yyy").format(data.date!)),
                ),
              );
            }
          );

        },
    );
  } 

}