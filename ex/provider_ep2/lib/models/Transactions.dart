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

Transactions transactionFromJson(String str) => Transactions.fromJson(json.decode(str));

String transactionToJson(Transactions data) => json.encode(data.toJson());

class Transactions {
    String? title;
    String? amount;
    DateTime? date;

    Transactions({
        this.title,
        this.amount,
        this.date,
    });

    factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
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