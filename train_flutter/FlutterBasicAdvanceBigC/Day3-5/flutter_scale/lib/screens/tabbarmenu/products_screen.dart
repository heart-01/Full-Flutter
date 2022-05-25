import 'package:flutter/material.dart';
import 'package:flutter_scale/models/ProductsModel.dart';
import 'package:flutter_scale/screens/editproduct/editproduct_screen.dart';
import 'package:flutter_scale/services/rest_api.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(  // pull to refresh ดึงลงแล้วโหลดข้อมูลใหม่
        onRefresh: () async { // Event ของ pull to refresh จะ return เป็น Future ต้องใช้เป็น async function
          setState(() {

          });
        },
        child: FutureBuilder(
          future: CallAPI().getProducts(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) // ถ้าโหลดข้อมูลไม่ได้ หรือมีข้อผิดพลาด
            {
              return const Center(child: Text('มีข้อผิดพลาดในการโหลดข้อมูล'));
            } else if (snapshot.connectionState ==
                ConnectionState.done) // ถ้าโหลดข้อมูลสำเร็จ
            {
              List<ProductsModel>? products = snapshot.data;
              return _listViewAllProducts(products!);
            } else {
              // ระหว่างที่กำหลังโหลดข้อมูล สามารถใส่ loading...
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(   //ปุ่มลอยขึ้นมาเพื่อกดเพิ่มสินค้า
        onPressed: () {
          Navigator.pushNamed(context, '/addproduct');
        },
        child: const Icon(Icons.add, color: Colors.white, size: 30),
        backgroundColor: Colors.blue,     // สีพื้นหลัง
        splashColor: Colors.blueAccent,   // เมื่อกดค้างจะเปลี่ยนสี
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  //----------------------------------
  // สร้าง ListView สำหรับการแสดงสินค้า
  //----------------------------------
  Widget _listViewAllProducts(List<ProductsModel> products) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: products.length,
      itemBuilder: (context, index) {
        ProductsModel productsModel = products[index];

        return Card(
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          // child: (productsModel.productImage != '') 
                          //   ? Image.network(productsModel.productImage)
                          //   : Image.asset('assets/images/noimgpic.jpeg'),
                          child: FadeInImage(
                            image: NetworkImage(productsModel.productImage),  // รูปภาพจะขึ้นหลังจากโหลดจาก Network แล้ว
                            placeholder: const AssetImage('assets/images/noimgpic.jpeg'), // รูปภาพจะขึ้นตอนตั้งต้น
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset('assets/images/badimg.png'); // รูปภาพจะขึ้นในกรณีโหลดรูปภาพไม่ได้
                            },
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productsModel.productName,
                                style: const TextStyle(fontSize: 24),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                productsModel.productBarcode,
                                style: const TextStyle(fontSize: 18),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                productsModel.productPrice,
                                style: const TextStyle(fontSize: 18),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      // Button Edit Product
                      ElevatedButton(
                        onPressed: () {
                          // ส่งค่าผ่าน route ไปเพื่อไปแสดงค่าเก่าก่อน update ถ้าไม่ใช้วิธีนี้จะใช้วิธีอ่านค่าจาก API ตาม product id ไปแสดงผลที่หน้า edit ก็ได้ในกรณีที่มีข้อมูลแยอะ
                          Navigator.pushNamed(
                            context, 
                              '/editproduct',
                              arguments: ScreenArguments(   // ส่ง arguments เพื่อนำ data ใน text field ไป map กับ Class ScreenArguments ในหน้า editproduct_screen แล้ว Class ScreenArguments จะส่งค่าไปสร้าง Widget text field
                                productsModel.id.toString(),
                                productsModel.productName.toString(), 
                                productsModel.productDetail.toString(), 
                                productsModel.productBarcode, 
                                productsModel.productPrice, 
                                productsModel.productQty, 
                                productsModel.productImage
                              )
                          ).then((value) => setState(() { // เมื่อส่งค่าแล้วทำการแก้ไขข้อมูลเสร็จให้ refresh หน้า Screen แล้ว CallAPI getProducts ใหม่อีกครั้ง
                            CallAPI().getProducts();
                          }));
                        },
                        child: const Text('แก้ไข'),
                        style: ElevatedButton.styleFrom(primary: Colors.yellow[900]),
                      ),
                      
                      const SizedBox(width: 10),

                      // Button Delete Product
                      ElevatedButton(
                        onPressed: () async {
                          return showDialog<void>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context){
                              return AlertDialog(
                                title: const Text('ยืนยันการลบข้อมูล'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: const [
                                      Text('รายการนี้จะถูกลบออกอย่างถาวร'),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('ไม่ลบ'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('ยืนยัน'),
                                    // เมื่อกดปุ่มยืนยันการลบ
                                    onPressed: () async {
                                      // Call API ลบสินค้าแนบ id product ไปด้วย
                                      var response = await CallAPI().deleteProduct(productsModel.id.toString());
                                      if (response == true) {
                                        //Navigator.pushNamed(context, '/stockscreen');
                                        Navigator.pop(context, true); // ปิด popup
                                        setState(() { // หลังปิด popup ให้เรียก api product ใหม่
                                          CallAPI().getProducts();
                                        });
                                      }
                                    },
                                  ),
                                ],
                              );
                            }
                          );
                        },
                        style: ElevatedButton.styleFrom(primary: Colors.red[700]),
                        child: const Text('ลบ'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
