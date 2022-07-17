import 'package:flutter/foundation.dart';
import 'package:provi/database/transaction_db.dart';
import 'package:provi/models/Transactions.dart';

class TransactionProvider with ChangeNotifier { //ออกแบบ Provider
  //ตัวอย่างก้อนข้อมูล
  List<Transactions> transactions = [];

  //ดึงข้อมูล
  List<Transactions> getTransaction(){
    return transactions;
  }

  void initData() async {
    var db = TransactionDB(dbName: "transactions.db"); //สร้าง Object ชื่อ db และเรียกใช้ Constructor
    //ดึงข้อมูลมาแสดงผล
    transactions = (await db.loadAllData())!;
    //แจ้งเตือนไปให้ Consumer ที่เชื่อมอยู่กับ TransactionProvider ว่ามีข้อมูลเพิ่มเข้ามาให้ Render Widget ใหม่
    notifyListeners();
  }

  //เพิ่มข้อมูล
  void addTransaction(Transactions statement) async {
    //var db = await TransactionDB(dbName: "transactions.db").openDatabase(); //เรียกใช้ class TransactionDB และ method openDatabase
    //print(db); //แสดงตำแหน่งที่จะจัดเก็บข้อมูลในฐานข้อมูล

    var db = TransactionDB(dbName: "transactions.db"); //สร้าง Object ชื่อ db และเรียกใช้ Constructor
    //บันทึกข้อมูล
    await db.InsertData(statement); //ให้ Object db เรียกใช้ Method InsertData และส่งข้อมูลของแบบฟอร์มไปให้ด้วย
    
    //ดึงข้อมูลมาแสดงผล
    transactions = (await db.loadAllData())!;

    //แจ้งเตือนไปให้ Consumer ที่เชื่อมอยู่กับ TransactionProvider ว่ามีข้อมูลเพิ่มเข้ามาให้ Render Widget ใหม่
    notifyListeners();
  }

}