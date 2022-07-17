import 'package:flutter/material.dart';
import 'package:provi/models/Transaction.dart';
import 'package:provi/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatelessWidget {
  
  final formKey = GlobalKey<FormState>(); //ผูก formKey

  //รับค่าข้อมูล form ด้วย controller
  final titleController = TextEditingController(); //รับค่า title
  final amountController = TextEditingController(); //รับค่า amount

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แบบฟอร์มบันทึกข้อมูล'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: titleController,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'ชื่อรายการ',
                ),
                validator: (String? str){
                  if(str!.isEmpty){
                    return 'กรุณาป้อนชื่อรายการ';
                  }
                  return null; //คือการไม่ติด validator
                },
              ),
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'จำนวนเงิน',
                ),
                validator: (String? str){
                  if(str!.isEmpty){
                    return 'กรุณาป้อนจำนวนเงิน';
                  }
                  return null; //คือการไม่ติด validator
                },
              ),
              Container(
                margin: EdgeInsets.all(8.0),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FlatButton(
                      child: Text('เพิ่มข้อมูล'),
                      color: Colors.purple,
                      textColor: Colors.white,
                      onPressed: () {
                        if(formKey.currentState!.validate()) //formKey.currentState!.validate() กรณีที่ไม่เจอข้อผิดพลาด
                        {
                          var title = titleController.text;
                          var amount = amountController.text;
                          print(title);

                          //เตรียมข้อมูลก่อนที่จะลง Provider
                          Transaction data = Transaction( //ตัวแปร Object
                            title: title,
                            amount: amount,
                            date: DateTime.now()
                          );

                          //เรียก provider ที่ต้องการเพิ่มข้อมูลลงไป
                          TransactionProvider provider = Provider.of<TransactionProvider>(context, listen:false); // of<ให้ระบุชื่อ Provider ที่เราต้องการให้ทำงาน>  listen:false คือ กำหนดให้ยังไม่มีคำขอหรือยังไม่มีการแจ้งเตือนอะไรไป
                          provider.addTransaction(data); //เรียกใช้ method เพื่อเพิ่ม data ลง TransactionProvider

                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
