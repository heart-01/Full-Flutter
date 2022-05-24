import 'package:flutter/material.dart';
import 'package:flutter_scale/models/ProductsModel.dart';
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
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('แก้ไข'),
                        style: ElevatedButton.styleFrom(primary: Colors.yellow[900]),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () async {},
                        style: ElevatedButton.styleFrom(primary: Colors.red[700]),
                        child: const Text('ลบ'),
                      )
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
