import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provi/models/Transactions.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TransactionDB {
  //บริการเกี่ยวกับฐานข้อมูล local

  String? dbName; //เก็บชื่อฐานข้อมูล

  TransactionDB({
    this.dbName,
  });

  Future<Database?> openDatabase() async {
    //อ้างอิงตำแหน่งของฐานข้อมูล ของผู้ใช้ ABC เช่น user/a , user/b , user/c
    Directory appDirectory = await getApplicationDocumentsDirectory(); //หาตำแหน่งที่จะเก็บข้อมูล เช่น c:/users/heart
    String dbLocation = join(appDirectory.path, dbName); //ระบุที่จะจัดเก็บข้อมูล //join คือ การต่อ String // ถ้า dbName เข้ามาเป็น transaction.db จะได้ c:/users/heart/transaction.db

    //สร้าง databases
    //ถ้ายังไม่ถูกสร้าง => ให้สร้าง
    //ถ้าสร้างไว้แล้ว => เปิด
    DatabaseFactory dbFactory = await databaseFactoryIo; //dbFactory จะเป็นตัวสร้าง databases
    Database db = await dbFactory.openDatabase(dbLocation); //สร้าง database และเปิด openDatabase ในตำแหน่งที่ dbLocation อยู่

    return db;    
  }

  //Store เปรียบเหมือน ตารางในฐานข้อมูล
  Future<int?> InsertData(Transactions statement) async {
    //ฐานข้อมูล => Store
    //ชื่อ dbName => expense
    var db = await this.openDatabase(); //ดึงตำแหน่งของ database
    var store = intMapStoreFactory.store("expense"); //สร้าง store ลง database ชื่อ expense
    
    //เก็บข้อมูลลง store ในรูปแบบ Json และส่ง KeyId กลับไป
    var keyId = store.add(db!, {
      "title" : statement.title,
      "amount" : statement.amount,
      "date" : statement.date!.toIso8601String(), //toIso8601String จัดรูปแบบ date
    });

    db.close(); //ปิดฐานข้อมูล

    return keyId; //จะนับเป็นเลข 1, 2, 3, 4, 5, 6, 7
  }

  Future<List<Transactions>?> loadAllData() async {
    var db = await this.openDatabase(); //ดึงตำแหน่งของ database
    var store = intMapStoreFactory.store("expense"); //reference node expense

    var snapshot = await store.find(db!, finder: Finder(sortOrders: [SortOrder(Field.key, false)])); //snapshot คือ ผลจากการไปดึงข้อมูล store expense จะได้ข้อมูลเปํน json object //sortOrders คือการเรียงลำดับ หลัง Field. คือ ชื่อ Field ที่ต้องการเรียงลำดับ และ ถ้าเป็น false จะเรียงจากมากไปน้อย
    // print(snapshot);

    List<Transactions> transactionList = []; //ดึงข้อมูลจาก snapshot มาใส่ในตัวแปร transactionList
    for(var record in snapshot){ //loop insert data to list
      transactionList.add(
        Transactions(
          title: record["title"].toString(),
          amount: record["amount"].toString(),
          date: DateTime.parse(record["date"].toString()), //แปลงข้อมูลวันที่กลับมาเป็น DateTime
        )
      );
    }

    return transactionList;
  }
  

}