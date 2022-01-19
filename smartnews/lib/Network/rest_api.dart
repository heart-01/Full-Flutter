import 'package:http/http.dart' as http;
import 'package:smart_news/Model/NewsDetailModel.dart';
import 'package:smart_news/Model/NewsModel.dart';
import 'package:smart_news/Utils/constant.dart';

class CallAPI {

  // กำหนด header ของ api
  _setHeaders() => {
    'Content-Type':'application/json',
    'Accept': 'application/json'
  };

  // กำหนด header สำหรับ Auth
  _setHeadersAuth() => {
    'Content-Type':'application/x-www-form-urlencoded'
  };

  // Login Auth
  loginCustomer(data) async {

    return await http.post(
      Uri.parse(baseAPIURL+'jwt-auth/v1/token'),
      headers: _setHeadersAuth(),
      body: data
    );
    
  }

  // เขียน API อ่านข่าวล่าสุด
  Future<List<NewsModel>?> getLastNews() async {

    final response = await http.get(
      Uri.parse(baseAPIURL+'wp/v2/posts?per_page=10&_embed'),
      headers: _setHeaders()
    );

    if(response.body.isNotEmpty){
      return newsModelFromJson(response.body);
    }else{
      return null;
    }

  }

  // เขียน API อ่านข่าวตามหมวดหมู่
  Future<List<NewsModel>?> getNewsByCategory(id) async {

    final response = await http.get(
      Uri.parse(baseAPIURL+'wp/v2/posts?categories=$id&_embed'),
      headers: _setHeaders()
    );

    if(response.body.isNotEmpty){
      return newsModelFromJson(response.body);
    }else{
      return null;
    }

  }

  // เขียน API อ่านรายละเอียดข่าว
  Future<NewsDetailModel?> getNewsDetail(id) async {

    final response = await http.get(
      Uri.parse(baseAPIURL+'wp/v2/posts/$id?_embed'),
      headers: _setHeaders()
    );

    if(response.body.isNotEmpty){
      return newsDetailModelFromJson(response.body);
    }else{
      return null;
    }

  }

}