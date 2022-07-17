import 'package:flutter/foundation.dart';
import 'package:provi/models/Transaction.dart';

class TransactionProvider with ChangeNotifier { //ออกแบบ Provider
  //ตัวอย่างก้อนข้อมูล
  List<Transaction> transactions = [
    // Transaction(title: 'หนังสือ', amount: '500', date: DateTime.now()),
    // Transaction(title: 'เสื้อผ้า', amount: '900', date: DateTime.now()),
    // Transaction(title: 'กางเกง', amount: '400', date: DateTime.now()),
  ];

  //ดึงข้อมูล
  List<Transaction> getTransaction(){
    return transactions;
  }

  //เพิ่มข้อมูล
  addTransaction(Transaction statement){
    //transactions.add(statement); //แทรกข้อมูลลงจากด้านล่างสุดของ List
    transactions.insert(0, statement); //แทรกข้อมูลลงจากด้านบนสุดของ List

    //แจ้งเตือนไปให้ Consumer ที่เชื่อมอยู่กับ TransactionProvider ว่ามีข้อมูลเพิ่มเข้ามาให้ Render Widget ใหม่
    notifyListeners();
  }

}