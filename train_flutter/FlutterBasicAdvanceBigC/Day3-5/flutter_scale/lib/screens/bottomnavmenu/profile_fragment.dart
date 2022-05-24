import 'package:flutter/material.dart';
import 'package:flutter_scale/models/UserModel.dart';
import 'package:flutter_scale/services/rest_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({Key? key}) : super(key: key);

  @override
  State<ProfileFragment> createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {

  // สร้าง Object sharedprefference เพื่อจะดึงข้อมูลใน localstorage 
  late SharedPreferences? sharedPreferences;

  // สร้าง Object userModel จาก Class UserModel เพื่อใช้งาน Model
  UserModel? userModel;
  
  // ตัวแปรเก็บ fullname , username , avatar
  String? _fullname, _username, _avatar;

  // function readUserProfile() ดึงข้อมูลโปรไฟล์จาก API
  readUserProfile() async {
    sharedPreferences = await SharedPreferences.getInstance();
    // CallAPI getProfile เอา UserID ที่อยู่ใน localstorage โยนเข้าไปใน function Call API
    var response = await CallAPI().getProfile(sharedPreferences!.getString('userID')); 
    setState(() {
      userModel = response; // นำค่าจาก API response ไปใส่ใน userModel
      _fullname = userModel!.fullname; // นำค่าจาก model ใส่เข้าไปในตัวแปร
      _username = userModel!.username;
      _avatar = userModel!.imgProfile;
    });
  }

  @override
  void initState() {
    super.initState();
    readUserProfile(); // เรียกใช้งาน function readUsesProfile
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        
        // Header Profile
        Container( // รูปภาพ พื้นหลัง Images Profile
          height: 200,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPPx_BIU4JoMYdFjRBByZEmCA4mv_2RCidT0RtNRAJOuI3LmIVfP9jfWSQg9Vf2Cnx7kY&usqp=CAU' ?? "..."),
              fit: BoxFit.cover,
            )
          ),

          // Profile Avatar
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // กรอบ Profile Avatar
              CircleAvatar(
                radius:50.0,
                backgroundColor: Colors.white,

                // Image Profile Avatar
                child: _avatar != null ? CircleAvatar(
                  radius: 46.0,
                  backgroundImage: NetworkImage('https://www.itgenius.co.th/sandbox_api/mrta_flutter_api/public/images/profile/'+_avatar!),
                ) : const CircularProgressIndicator()
              ),
              
              // fullname และ username
              Text(_fullname ?? '...', style: const TextStyle(fontSize: 24.0, color: Colors.white)),
              Text(_username ?? '...', style: const TextStyle(fontSize: 16.0, color: Colors.white)),
            ],
          ),
        ),

        // List title เมนูผู้ใช้งาน
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('ข้อมูลผู้ใช้'),
          trailing: const Icon(Icons.navigate_next),
          visualDensity: const VisualDensity(vertical: -4), // ขยับแนวตั้ง
          // horizontalTitleGap: 5, // ขยับข้อมูลแนวนอน
          // dense: true,
          onTap: (){},
        ),
        ListTile(
          leading: const Icon(Icons.lock),
          title: const Text('เปลี่ยนรหัสผ่าน'),
          trailing: const Icon(Icons.navigate_next),
          visualDensity: const VisualDensity(vertical: -4),
          onTap: (){},
        ),
        ListTile(
          leading: const Icon(Icons.language),
          title: const Text('เปลี่ยนภาษา'),
          trailing: const Icon(Icons.navigate_next),
          visualDensity: const VisualDensity(vertical: -4),
          onTap: (){},
        ),
        ListTile(
          leading: const Icon(Icons.email),
          title: const Text('ติดต่อทีมงาน'),
          trailing: const Icon(Icons.navigate_next),
          visualDensity: const VisualDensity(vertical: -4),
          onTap: (){},
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('ตั้งค่าใช้งาน'),
          trailing: const Icon(Icons.navigate_next),
          visualDensity: const VisualDensity(vertical: -4),
          onTap: (){},
        ),
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: const Text('ออกจากระบบ'),
          trailing: const Icon(Icons.navigate_next),
          visualDensity: const VisualDensity(vertical: -4),
          onTap: () async {
            sharedPreferences = await SharedPreferences.getInstance();
            sharedPreferences!.clear(); // ลบข้อมูล sharedPreferences ที่อยู่ใน localstoreage ออกทั้งหมด
            Navigator.pushReplacementNamed(context, '/login');  // กลับไปหน้า login
          },
        )


      ],
    );
  }
}
