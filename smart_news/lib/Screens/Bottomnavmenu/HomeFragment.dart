import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_news/Models/NewsModel.dart';
import 'package:smart_news/Network/rest_api.dart';
import 'package:smart_news/Screens/Bottomnavmenu/MenuList.dart';
import 'package:smart_news/Themes/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smart_news/Utils/Images.dart';
import 'package:smart_news/Utils/Widgets.dart';
import 'package:smart_news/Utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:html/parser.dart' show parse;
import 'package:intl/intl.dart';

class HomeFragment extends StatefulWidget {
  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> with SingleTickerProviderStateMixin { //with SingleTickerProviderStateMixin เป็นการ implement จัดการ state แค่ครั้งเดียวโหลดใหม่เสมอ ไม่ให้เก็บ state เก่าไว้

  // สร้าง Object SharedPreferences
  SharedPreferences? sharedPreferences;
  // สร้างตัวแปรเก็บค่า Session
  String? fname, lname, email;
  int? storeStep;

  //สร้าง TabController ไว้แสดง tab เมนู
  TabController? tabController;

  //กำหนดหมวดหมู่เริ่มต้น
  int? _categoryID = 0;
  //ตัวแปรใช้ใน function onTabChanged
  int? index = 0;

  //สร้าง List ของ Tab เก็บลงตัวแปร Map
  Map<int, int> tabCategory = {
    0:0, 
    1:12, //เลข 12 คือ เลขหมวดหมู่ของ api เลข 1 คือ index
    2:3,
    3:2,
    4:4,
    5:5,
    6:6,
    7:1,
    8:7,
    9:11
  };
  //List ชื่อของ tab
  List<Widget> tabs = [
    Tab(text: 'Home',),
    Tab(text: 'Authoritative Parenting',),
    Tab(text: 'Baby Games',),
    Tab(text: 'Bathtime & Grooming',),
    Tab(text: 'Diet',),
    Tab(text: 'Health',),
    Tab(text: 'Parental alienation',),
    Tab(text: 'Parenting',),
    Tab(text: 'Parenting coordinator',),
    Tab(text: 'Paternal care',),
  ];

  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  getUserProfile() async {    
    sharedPreferences = await SharedPreferences.getInstance(); //ดึงข้อมูล Session
    setState(() {
      fname = sharedPreferences!.getString('storefirstName'); //sharedPreferences ! ต้องมีข้อมูล session storefirstName
      lname = sharedPreferences!.getString('storelastName');
      email = sharedPreferences!.getString('storeemail');

      if(sharedPreferences!.getInt('storeStep') != null){
        storeStep = sharedPreferences!.getInt('storeStep')!;
      }else{
        storeStep = 0;
      }
      
    });
  }

  _logout() async {
    sharedPreferences = await SharedPreferences.getInstance();
    // Clear ค่าของ sharedPreferences หรือ session 
    // sharedPreferences!.clear(); // Clear session ทั้งหมด
    sharedPreferences!.setInt('storeStep', 0); //Update session
    print(storeStep);
    Navigator.popAndPushNamed(context, '/login');
  }

  @override
  void initState() {  //ทำงานตอนโหลดครั้งแรก
    super.initState();
    getUserProfile();

    //ทดสอบเรียกใช้งาน API อ่านข่าวล่าสุด
    // CallApi().getLastNews().then((response) { //response ที่ได้มาจาก ่method CallApi().getLastNews()
      // print(response); //แสดงผล string
      // inspect(response); //ดูข้อมูล Object เราต้องกดสลับ tab ดูเพื่อให้ load ข้อมูลดู เพราะ การทำงานเป็นแบบ async
      // print(response![0].title!.rendered); //แสดงผลแบบ array ตัว model จะกำหนดไว้แล้ว เราต้องกดสลับ tab ดูเพื่อให้ load ข้อมูลดู เพราะ การทำงานเป็นแบบ async
    // });

    // ใช้คู่กับ SingleTickerProviderStateMixin
    // จัดการ Tabcontroller ให้สามารถเรียกใช้งาน state ได้ทุกครั้งที่เปลี่ยน 
    //บังคับให้มีการ Render ใหม่เสมอเมื่อมีการกด Tab เพื่อแก้ปัญหากดแล้วไม่รีเฟรซข้อมูลใหม่
    tabController = TabController(
      length: tabs.length, //ขนาดจำนวนของ Tab
      vsync: this //ทำการ sync ทุกครั้งเมื่อมีการเปลี่ยน state ต้องรีเฟรชตลอดเมื่อ state เปลี่ยน
    );
    tabController!.animation!.addListener(onTabChanged); //เมื่อมีการเปลี่ยน tab ให้มีการเรียก function onTabChanged มาช่วย

  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController( //widget DefaultTabController ไว้ควบคุมพวก tab หมวดหมู่
      length: tabs.length, //จำนวนของ tab
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Smart News',
            style: TextStyle(color: textColorSecondary),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.video_call),
              onPressed: () {},
            )
          ],
          bottom: TabBar( //กำหนดให้ tab อยู่ด้านล่าง scaffold
            tabs: tabs,
            labelPadding: EdgeInsets.only(left: 10, right: 10),
            controller: tabController, //ใช้ควบคุม tab
            indicatorWeight: 4.0,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: primaryColor,
            labelColor: textColorSecondary,
            labelStyle: TextStyle(fontSize: 18.0),
            isScrollable: true,
            onTap: (index) {
              // print(index); //ค่า index ของ tab
              // setState(() {
              //   _categoryID = tabCategory[index];
              // });

              tabController!.addListener(() { //เช็คการเปลี่ยนแปลง tab
                if(!tabController!.indexIsChanging) //ถ้า tabController เปลี่ยนให้มีการ Render หน้าทุกครั้งเมื่อมีการ chang หน้า หรือ เปลี่ยนหน้า //ถ้าเอา ! ออกจะ Render หน้าแค่ครั้งเดียว
                {
                  setState(() {
                    _categoryID = tabCategory[index];
                  });
                }
              });

              print(_categoryID); //แสดงค่า id ตาม index ของตัวแปร tabCategory
            },
          ),
        ),
        drawer: Theme(
          data: Theme.of(context)
              .copyWith(canvasColor: googleColor), // ใช้ theme ในการเทสีพื้นหลัง drawer
          child: Drawer(
            child: ListView(
              children: [
                storeStep == 1 ? //ถ้ามีข้อมูลการ login
                UserAccountsDrawerHeader(
                  accountName: Text('$fname $lname'),
                  accountEmail: Text('$email'),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/User_profile.png'),
                  ),
                  decoration: BoxDecoration(color: googleColor),
                )
                :
                Container(),

                // for (final menu in menus) //แบบที่ 1 Loop list array menu ใช้ในกรณีเรารู้ค่าแล้วไม่มีการเพิ่มลบ parameter บ่อย ๆ
                //   ListTile(
                //     leading: Icon(menu.micon),
                //     title: Text(menu.mname),
                //     onTap: () {
                //       menu.onTap();
                //     },
                //   ),
                storeStep == 0 ? 
                MenuList(
                    micon: Icons.login,
                    mname: 'Login',
                    onTap: () {
                      // Navigator.pop(context); //ปิดตัวเองลงไป
                      Navigator.popAndPushNamed(context,
                          '/login'); //เปิดหน้าใหม่ตาม files routes แล้วปิดตัวเองลงไป
                    })
                    :
                Container(),
                MenuList(
                    micon: Icons.new_releases,
                    mname: 'Lastest news',
                    onTap: () {
                      Navigator.pushNamed(context,
                          '/lastest_news'); //เปิดหน้าใหม่ตาม files routes
                    }),
                MenuList(
                    micon: Icons.category,
                    mname: 'Category',
                    onTap: () {
                      Navigator.pushNamed(
                          context, '/category'); //เปิดหน้าใหม่ตาม files routes
                    }),
                MenuList(
                    micon: Icons.video_collection,
                    mname: 'Video List',
                    onTap: () {
                      Navigator.pushNamed(
                          context, '/videolist'); //เปิดหน้าใหม่ตาม files routes
                    }),
                MenuList(
                    micon: Icons.info,
                    mname: 'About',
                    onTap: () {
                      Navigator.pushNamed(
                          context, '/about'); //เปิดหน้าใหม่ตาม files routes
                    }),
                MenuList(
                    micon: Icons.settings,
                    mname: 'Setting',
                    onTap: () {
                      Navigator.pushNamed(
                          context, '/setting'); //เปิดหน้าใหม่ตาม files routes
                    }),
                storeStep == 1 ? MenuList( //ถ้ามีข้อมูลการ login 
                    micon: Icons.logout,
                    mname: 'Logout',
                    onTap: _logout 
                )
                : 
                Container(),
              ],
            ),
          ),
        ),

        body: TabBarView( //TabBarView widget กำหนดให้มีการแสดงผลตามที่ tab กด
          physics: NeverScrollableScrollPhysics(), //ปิดการปัดซ้ายปัดขวาของ TabBarView
          controller: tabController,
          children: tabs.map((e) { //map tabs เข้ากับ TabBarView
            int index = tabs.indexOf(e); //index tab ตอนกด ปุ่ม
            
            if(index == 0){ //ถ้าเป็น index แรกของ tab
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(HEAD_SLIDE_TEXT, style: TextStyle(fontSize: 20.0),),
                    ),
              
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4, //สูง 25% ของหน้าจอ // MediaQuery.of(context).size.height ดึงความสูงของหน้าจอ
                      width: double.infinity, //กว้างเต็มหน้าจอ
                      child: CarouselSlider( //image slider
                      options: CarouselOptions( //ตั้งค่า slider
                        aspectRatio: 1.0,
                        enlargeCenterPage: false,
                        enableInfiniteScroll: false,
                        viewportFraction: 1.0,
                        autoPlay: true,
                      ),
                      items: imgList
                          .map((item) => Container(
                                child: Center(
                                    child:
                                        Image.network(item, fit: BoxFit.cover, width: 1000)),
                              ))
                          .toList(),
                    )),
              
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(TEXT_LATEST_NEWS, style: TextStyle(fontSize: 20.0),),
                    ),
              
                    // for(int i=0; i<=5; i++)

                    //ListView ไว้สำหรับแสดงข่าว
                    FutureBuilder //FutureBuilder เป็น Widget loop ข้อมูลใน Model จะมีระบบจัดการพวก loading เวลาหาข้อมูลไม่เจอ หรือ รอเวลาโหลด API
                    (  
                      future: CallApi().getLastNews(), //future จะอ่านข้อมูลรับมาจาก API เป็นการ CallAPI ทำให้รู้ว่ามีอะไรบ้าง
                      builder: (BuildContext context, //builder คือเนื้อหาที่จะดึงเข้ามาใส่ข้อมูล มี 3 parameter 1.เป็น context จะทำงานได้ก็ต่อเมื่ออยู่ใต้ Widget build(BuildContext context) 
                        AsyncSnapshot<List<NewsModel>?> snapshot) // 2.AsyncSnapshot  เวลาการส่งข้อมูลมาจะส่งผ่าน Snapshot แล้วเอา List ของ Model มาใส่ ในตัวแปร snapshot
                        {
                          //snapshot จะมีการ return ค่าออกมาเป็น respon 3 สถานะ 1.กรณี error 2.success 3.กำลัง load
                          if(snapshot.hasError) //กรณีที่โหลดข้อมูลแล้วผิดพลาด
                          {
                            return Container(child: Text('มีข้อผิดพลาดในการโหลดข้อมูล'));
                          }else if(snapshot.connectionState == ConnectionState.done) //กรณีโหลดข้อมูลสำเร็จ
                          { 
                            List<NewsModel>? news = snapshot.data; //ดึงข้อมูล snapshot.data มาใส่ในตัวแปร  List<NewsModel>? news 
                            // print(news); //inspect(news);
                            return listViewNews(news!); //เรียกใช้ widget ดึงข้อมูลเติมข้อมูลตามที่ตั้งไว้
                          }else //กรณีโหลดข้อมูลอยู่
                          { 
                            return Center(
                              child: CircularProgressIndicator(), //รูปโหลดข้อมูล
                            );
                          }
                        }
                    ),
                    
                  ],
                ),
              );
            }else if(index >= 1){ //ถ้าเป็น tab อื่นที่ไม่ใช่ tab แรก
              return SingleChildScrollView( //Listview สำหรับเลื่อนๆได้
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //ListView ไว้สำหรับแสดงข่าวตาม id category
                    FutureBuilder //FutureBuilder เป็น Widget loop ข้อมูลใน Model จะมีระบบจัดการพวก loading เวลาหาข้อมูลไม่เจอ หรือ รอเวลาโหลด API
                    (  
                      future: CallApi().getNewsByCategory(_categoryID), //future จะอ่านข้อมูลรับมาจาก API เป็นการ CallAPI ทำให้รู้ว่ามีอะไรบ้าง
                      builder: (BuildContext context, //builder คือเนื้อหาที่จะดึงเข้ามาใส่ข้อมูล มี 3 parameter 1.เป็น context จะทำงานได้ก็ต่อเมื่ออยู่ใต้ Widget build(BuildContext context) 
                        AsyncSnapshot<List<NewsModel>?> snapshot) // 2.AsyncSnapshot  เวลาการส่งข้อมูลมาจะส่งผ่าน Snapshot แล้วเอา List ของ Model มาใส่ ในตัวแปร snapshot
                        {
                          //snapshot จะมีการ return ค่าออกมาเป็น respon 3 สถานะ 1.กรณี error 2.success 3.กำลัง load
                          if(snapshot.hasError) //กรณีที่โหลดข้อมูลแล้วผิดพลาด
                          {
                            return Container(child: Text('มีข้อผิดพลาดในการโหลดข้อมูล'));
                          }
                          else if(snapshot.connectionState == ConnectionState.done) //กรณีโหลดข้อมูลสำเร็จ
                          { 
                            List<NewsModel>? news = snapshot.data; //ดึงข้อมูล snapshot.data มาใส่ในตัวแปร  List<NewsModel>? news 
                            // print(news); //inspect(news);
                            return listViewNews(news!); //เรียกใช้ widget ดึงข้อมูลเติมข้อมูลตามที่ตั้งไว้
                          }
                          else //กรณีโหลดข้อมูลอยู่
                          { 
                            // return Center(    
                            //   child: CircularProgressIndicator(), //รูปโหลดข้อมูล
                            // );

                            return Padding(
                              padding: const EdgeInsets.only(top:150.0),
                              child: SizedBox(
                                height: 200.0,
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        child: new CircularProgressIndicator(
                                          strokeWidth: 1,
                                          color: primaryColor,
                                          value: 1.0,
                                        ),
                                      ),
                                    ),
                                    Center(child: Text("กำลังโหลด...")),
                                  ],
                                ),
                              ),
                            );

                          }
                        }
                    ),
                  ],
                ),
              );
            }else{ // if จะต้องใส่ else ด้วยไม่งั้นจะ error
              return Center(child: Text('No data'),);
            }
          }).toList(),
        ),
      ),
    );
  }

  //เป็น function คอยตรวจเช็คว่า Tab มีการเปลี่ยนค่าไปแล้วรึยัง
  void onTabChanged() {
    final aniValue = tabController!.animation!.value;  //aniValue เป็นตัวแปรเก็บค่าว่าเปลี่ยนค่าไปแล้วรึยัง
    if (aniValue > 0.5 && index != 1) {
      setState(() {
        index = 1;
      });
    } else if (aniValue <= 0.5 && index != 0) {
      setState(() {
        index = 0;
      });
    }
  }
  
}
