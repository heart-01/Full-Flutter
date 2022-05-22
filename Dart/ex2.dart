// Variable
void main(){
// ชนิดข้อมูล (Data Type) ในภาษา Dart มีดังนี้
/*
*int เก็บเลขจำนวนเต็ม เช่น 8,1, -5,8955
*double เลขทศนิยม เช่น 8.8, 8.15, -2.50
*num เลขจำนวนเต็มหรือทศนิยมก็ได้ เช่น 135, 0.145
*bool เก็บค่าทางตรรกศาสตร์ เช่น true, false
*String ihuốnU5% änanus 1zhu 'Hello World',"Hi every body"
*dynamic ตัวแปรแบบเปลี่ยนแปลงค่าได้
*Lists รายการข้อมูลหรือ Arrays
*Sets เก็บข้อมุลแบบ set ค่าไม่ซ้ำ
*Maps เก็บข้อมูลแบบคู่ Key :Value
*Runes เก็บตัวอักษรแบบเดี่ยว Unicode 32bit
*Symbols เก็บสัญลักษณ์อื่นๆ
*/

  // Null Safety
  int x;
  x=10;
  String? firstname;// ใส่เครื่องหมาย?เป็นการบอกว่าอนุญาติให้เป็น null ได้
  print(x);
  print(firstname);

  // การสร้างตัวแปรแบบ dynamic type
  var fname = "Samit";
  var lname = "Koyom";
  print(info(fname, lname ?? '_' ));
  // print(info(fname, lname!));

}

String info(String fname, String lname){
  return fname +' '+lname;
}