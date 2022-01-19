import 'package:book_phone/service/myalert.dart';
import 'package:flutter/material.dart';

class Mylist extends StatelessWidget {
  final String? name, tel, url, image;
  final ontab;
  final delete, edit;

  const Mylist({
    //Constructor set property
    Key? key,
    this.name,
    this.tel,
    this.image,
    this.url,
    this.ontab,
    this.delete,
    this.edit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("$name"),
      subtitle: Text("$tel"),
      leading: image == null
          ? CircleAvatar(
              backgroundColor: Colors.orange,
            )
          : CircleAvatar(
              backgroundColor: Colors.orange,
              backgroundImage: NetworkImage(image!),
            ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min, //กำหนดความสูงให้เท่ากันทั้งหมดของ Child
        children: [
          Container(
            height: 30,
            width: 30,
            child: RaisedButton(
              onPressed: edit,
              padding: EdgeInsets.all(2),
              color: Colors.orange,
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            height: 30,
            width: 30,
            child: RaisedButton(
              onPressed: () {
                Myalert.onAlertButtonsPressed(
                  context,
                  "ยืนยันการลบข้อมูล",
                  "",
                  delete,
                );
              },
              padding: EdgeInsets.all(2),
              color: Colors.redAccent,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      onTap: ontab,
    );
  }
}
