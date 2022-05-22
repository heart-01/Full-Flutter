import 'package:flutter/material.dart';
import 'package:flutter_scale/screens/bottomnavmenu/home_fragment.dart';
import 'package:flutter_scale/screens/bottomnavmenu/notification_fragment.dart';
import 'package:flutter_scale/screens/bottomnavmenu/profile_fragment.dart';
import 'package:flutter_scale/screens/bottomnavmenu/report_fragment.dart';
import 'package:flutter_scale/screens/bottomnavmenu/setting_fragment.dart';
import 'package:flutter_scale/screens/dashboard/menu_list.dart';
import 'package:flutter_scale/themes/colors.dart';
import 'package:flutter_scale/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  // index การกดปุ่ม BottomNavMenu
  late int _currentIndex = 0;

  // ตัวแปรไว้เก็บ title ของ BottomNavMenu
  String _titleAppBar = HOME_MENU;

  // ตัวแปรเก็บ List รายการ Widget ของ BottomNavMenu
  final List<Widget> _bottomNavMenu = const [
    HomeFragment(),
    ReportFragment(),
    NotificationFragment(),
    SettingFragment(),
    ProfileFragment()
  ];

  // method สำหรับการเปลี่ยนชื่อ appBar หลัdf.ช้ BottomNavMenu
  void onTabChange(int index){
    setState(() {
      _currentIndex = index;
      switch(index) {
        case 0: _titleAppBar = HOME_MENU; break;
        case 1: _titleAppBar = REPORT_MENU; break;
        case 2: _titleAppBar = NOTIFICATION_MENU; break;
        case 3: _titleAppBar = SETTING_MENU; break;
        case 4: _titleAppBar = PROFILE_MENU; break;
      }
    });
  }

  // --------------------------------------------------------
  // สร้าง Object SharedPreferences
  late SharedPreferences? sharedPreferences;
  // ตัวแปรเก็บค่า infoUser หลัง login
  String? username, fullname, imgprofile;
  void getUserProfile() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      username = sharedPreferences!.getString('userName');
      fullname = sharedPreferences!.getString('fullName');
      imgprofile = sharedPreferences!.getString('imgProfile');
    });
  }

  void _logout() async {
    // สร้าง Object sharedprefference เพื่อจะลบข้อมูลที่อยู่ใน localstorage 
    sharedPreferences = await SharedPreferences.getInstance();
    // เคลียร์ค่า Sharedprefference ทั้งหมดออก
    sharedPreferences!.clear();
    // sharedPreferences!.setInt('storeStep', 0); //Update session
    // ส่งไปหน้า login
    Navigator.of(context).pushReplacementNamed('/login');
  }
  // --------------------------------------------------------

  @override
  void initState() {  // ทำงานตอนเริ่ม build widget
    super.initState();
    getUserProfile();
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleAppBar),
      ),

      body: _bottomNavMenu[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabChange,
        currentIndex: _currentIndex,
        type:  BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: HOME_MENU),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart_outlined), label: REPORT_MENU),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_outlined), label: NOTIFICATION_MENU),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: SETTING_MENU),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: PROFILE_MENU),
        ],
      ),

      drawer: SizedBox(
        width: 250,
        child: Drawer(
          backgroundColor: Colors.teal,
          // ListView จะสามารถเปลี่ยนแปลงค่าได้ใน children นิยมนำมาทำ loop data ข้อมูลจะสามารถเลื่อนได้เมื่อล้นขอบ
          child: ListView( 
            children: [
              SizedBox(
                height: 70.0,
                child: DecoratedBox(
                  decoration: const BoxDecoration(color: Colors.blue),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Row(
                      children: [
                        // ถ้ามีรูปภาพให้แสดงผลเลย ถ้าไม่มีให้หมุนรอ
                        imgprofile != null ? CircleAvatar(
                          // backgroundImage: AssetImage('assets/images/cat.jpeg'),
                          backgroundImage: NetworkImage('https://www.itgenius.co.th/sandbox_api/mrta_flutter_api/public/images/profile/'+imgprofile!),
                        ) : const CircularProgressIndicator( color: inputTextColor, ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                fullname ?? '...', 
                                style: const TextStyle(color: Colors.white)
                              ),
                              Text(
                                username ?? '...', 
                                style: const TextStyle(color: Colors.white)
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10,),
              
              // Drawer Menu
              const MenuList(micon: Icons.info, mname: ABOUT_MENU, mtextColor: secondaryTextColor,),
              const MenuList(micon: Icons.book, mname: INFO_MENU, mtextColor: secondaryTextColor,),
              const MenuList(micon: Icons.email, mname: CONTACT_MENU, mtextColor: secondaryTextColor,),
              MenuList(
                mtitleColor: logoutBtnColor, 
                micon: Icons.exit_to_app, miconColor: secondaryTextColor,
                mname: LOGOUT_MENU, mtextColor: secondaryTextColor, 
                onTap: _logout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
