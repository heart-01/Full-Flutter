// class Transaction {
//   String? title; //ชื่อรายการ
//   double? amount; //จำนวนเงิน
//   DateTime? date; //วันที่ เวลา บันทึกรายการ

//   Transaction({
//     this.title,
//     this.amount,
//     this.date
//   });

// }

// To parse this JSON data, do
//
//     final transaction = transactionFromJson(jsonString);

import 'dart:convert';

Transaction transactionFromJson(String str) => Transaction.fromJson(json.decode(str));

String transactionToJson(Transaction data) => json.encode(data.toJson());

class Transaction {
    Transaction({
        this.title,
        this.amount,
        this.date,
    });

    String? title;
    String? amount;
    DateTime? date;

    factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        title: json["title"] == null ? null : json["title"],
        amount: json["amount"] == null ? null : json["amount"],
        date: json["date"] == null ? null : json["date"],
    );

    Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "amount": amount == null ? null : amount,
        "date": date == null ? null : date,
    };
}