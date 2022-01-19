// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_news/Model/NewsModel.dart';
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

class _HomeFragmentState extends State<HomeFragment> with SingleTickerProviderStateMixin {
  
  // สร้าง Object SharedPreferences
  SharedPreferences? sharedPreferences;

  String? fname, lname, email;
  int? storeStep;

  // กำหนดหมวดหมู่เริ่มต้น
  int? _categoryID = 0;

  // สร้าง TabController ไว้แสดง tab เมนู
  int? index = 0;
  TabController? tabController;

  // สร้าง List ของ Tab เก็บลงตัวแปรแบบ Map
  Map<int, int> tabCategory = {
    0: 0,
    1: 12,
    2: 3,
    3: 2,
    4: 4,
    5: 5,
    6: 6,
    7: 1,
    8: 7,
    9: 11
  };

  List<Widget> tabs = [
    Tab(
      text: 'Home',
    ),
    Tab(
      text: 'Authoritative Parenting',
    ),
    Tab(
      text: 'Baby Games',
    ),
    Tab(
      text: 'Bathtime & Grooming',
    ),
    Tab(
      text: 'Diet',
    ),
    Tab(
      text: 'Health',
    ),
    Tab(
      text: 'Parental alienation',
    ),
    Tab(
      text: 'Parenting',
    ),
    Tab(
      text: 'Parenting coordinator',
    ),
    Tab(
      text: 'Paternal care',
    ),
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
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {

      fname = sharedPreferences!.getString('storefirstName');
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
    // Clear ค่าของ sharedPreferences ทั้งหมด
    // sharedPreferences!.clear();
    sharedPreferences!.setInt('storeStep', 0);
    Navigator.popAndPushNamed(context, '/dashboard');
  }

  @override
  void initState() {
    super.initState();
    getUserProfile();

    // ทดสอบเรียกใช้งาน API อ่านข่าวล่าสุด
    // CallAPI().getLastNews().then((response) {
      // print(response);
      // inspect(response);
    //   print(response![0].title!.rendered);
    // });

    // การจัดการ Tabcontroller ให้สามารถเรียกใช้งาน state ได้ทุกครั้งที่เปลี่ยน
    tabController = TabController(vsync: this, length: tabs.length);
    tabController!.animation!.addListener(onTabChanged);

  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'Smart News',
            style: TextStyle(color: textColorSecondary),
          ),
          actions: [
            IconButton(
              icon: Image.asset(ic_video, color: Theme.of(context).textTheme.headline6!.color),
              onPressed: () {},
            ),
          ],
          bottom: TabBar(
            tabs: tabs,
            labelPadding: EdgeInsets.only(left: 10, right: 10),
            controller: tabController,
            indicatorWeight: 4.0,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: primaryColor,
            labelColor: textColorSecondary,
            labelStyle: TextStyle(fontSize: 18.0),
            isScrollable: true,
            onTap: (index) {

              // print(index);
              tabController!.addListener(() {
                if(!tabController!.indexIsChanging){
                  setState(() {
                    _categoryID = tabCategory[index];
                  });
                }
              });

              // print(_categoryID);
            },
          ),
        ),
        drawer: Theme(
          data: Theme.of(context).copyWith(canvasColor: googleColor),
          child: Drawer(
            child: ListView(
              children: [
                storeStep == 1
                    ? UserAccountsDrawerHeader(
                        accountName: Text('$fname $lname'),
                        accountEmail: Text('$email'),
                        currentAccountPicture: CircleAvatar(
                          backgroundImage:
                              AssetImage('images/User_profile.png'),
                        ),
                        decoration: BoxDecoration(color: googleColor),
                      )
                    : Container(),

                // แบบแรก
                // for (final menu in menus)
                //   ListTile(
                //     leading: Icon(menu.micon),
                //     title: Text(menu.mname),
                //     onTap:() { menu.onTap(); },
                //   ),

                storeStep == 0
                    ? MenuList(
                        micon: Icons.login,
                        mname: 'Login',
                        onTap: () {
                          Navigator.popAndPushNamed(context, '/login');
                        })
                    : Container(),

                MenuList(
                    micon: Icons.new_releases,
                    mname: 'Lastest news',
                    onTap: () {
                      Navigator.popAndPushNamed(context, '/lastest_news');
                    }),

                MenuList(
                    micon: Icons.category,
                    mname: 'Category',
                    onTap: () {
                      Navigator.popAndPushNamed(context, '/category');
                    }),

                MenuList(
                    micon: Icons.video_collection,
                    mname: 'Video Lists',
                    onTap: () {
                      Navigator.popAndPushNamed(context, '/videolist');
                    }),

                MenuList(
                    micon: Icons.info,
                    mname: 'About',
                    onTap: () {
                      Navigator.popAndPushNamed(context, '/about');
                    }),

                MenuList(
                    micon: Icons.settings,
                    mname: 'Setting',
                    onTap: () {
                      Navigator.popAndPushNamed(context, '/setting');
                    }),

                storeStep == 1
                    ? MenuList(
                        micon: Icons.logout, mname: 'Logout', onTap: _logout)
                    : Container(),
              ],
            ),
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          children: tabs.map((e) {

            int index = tabs.indexOf(e);

            if(index == 0){

              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        HEAD_SLIDE_TEXT,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),

                    Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: double.infinity,
                        child: CarouselSlider(
                          options: CarouselOptions(
                            aspectRatio: 1.0,
                            enlargeCenterPage: false,
                            enableInfiniteScroll: false,
                            viewportFraction: 1.0,
                            autoPlay: true,
                          ),
                          items: imgList
                              .map((item) => Container(
                                    child: Center(
                                        child: Image.network(item,
                                            fit: BoxFit.cover, width: 1000)),
                                  ))
                              .toList(),
                        )),

                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        TEXT_LATEST_NEWS,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),

                    FutureBuilder(
                      future: CallAPI().getLastNews(),
                      builder: (BuildContext context,
                        AsyncSnapshot<List<NewsModel>?> snapshot){
                          
                          // กรณีที่มีข้อผิดพลาด
                          if(snapshot.hasError){
                            return Container(child: Text('มีข้อผิดพลาดในการโหลดข้อมูล'),);
                          // ถ้าโหลดข้อมูลสำเร็จ
                          }else if(snapshot.connectionState == ConnectionState.done){
                            List<NewsModel>? news = snapshot.data;
                            return _listViewNews(news!);
                          // ถ้ากำลังโหลดข้อมูลอยู่
                          }else{
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }
                    ),

                  ],
                ),
              );
            }else if(index >= 1) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                      future: CallAPI().getNewsByCategory(_categoryID),
                      builder: (BuildContext context,
                        AsyncSnapshot<List<NewsModel>?> snapshot){
                          
                          // กรณีที่มีข้อผิดพลาด
                          if(snapshot.hasError){
                            return Container(child: Text('มีข้อผิดพลาดในการโหลดข้อมูล'),);
                          // ถ้าโหลดข้อมูลสำเร็จ
                          }else if(snapshot.connectionState == ConnectionState.done){
                            List<NewsModel>? news = snapshot.data;
                            return _listViewNews(news!);
                          // ถ้ากำลังโหลดข้อมูลอยู่
                          }else{
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
            }else{
              return Center(child: Text('No data.'),);
            }
          }).toList(),
        ),
      ),
    );
  }

  // สร้าง ListView สำหรับไว้แสดงข่าว
  Widget _listViewNews(List<NewsModel> news){
    return ListView.builder(
      itemCount: news.length,
      shrinkWrap: true,
      padding: EdgeInsets.all(8),
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index){

        // Load Model
        NewsModel newsModel = news[index];

        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/newsdetail', arguments: {'id': newsModel.id});
          },
          child: Container(
            padding: EdgeInsets.all(8),
            width: context.width(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Hero(
                  tag: newsModel.id!,
                  child: cachedImage(newsModel.embedded!.wpFeaturedmedia![0].sourceUrl.toString(),
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover)
                      .cornerRadiusWithClipRRect(10)
                      .visible(
                        newsModel.embedded!.wpFeaturedmedia![0].sourceUrl.toString().isNotEmpty,
                        defaultWidget: Image.asset(greyImage,
                        fit: BoxFit.cover,
                        height: 150,
                        width: 150)
                        .cornerRadiusWithClipRRect(10)
                      ),
                ),
                8.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        parseHtmlString(newsModel.title!.rendered),
                        style: boldTextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .headline6!
                                .color,
                            size: textSizeMedium),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      8.height,
                      Text(
                        parseHtmlString(newsModel.content!.rendered),
                        style:
                            secondaryTextStyle(size: textSizeSMedium),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                      8.height,
                      Align(
                        child: Text(
                            DateFormat.yMMMMd('en_US').format(
                                DateTime.parse(newsModel.dateGmt.toString())),
                            style: secondaryTextStyle(size: 11)),
                        alignment: Alignment.centerRight,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  String parseHtmlString(String? htmlString) {
    return parse(parse(htmlString).body!.text).documentElement!.text;
  }

  void onTabChanged() {
    final aniValue = tabController!.animation!.value;
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
