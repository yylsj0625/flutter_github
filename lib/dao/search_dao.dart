import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/model/common_model.dart';
import 'package:flutter_app/utils/favorite_list.dart';
import 'package:http/http.dart' as http;

const API_URL = 'https://api.github.com/search/repositories?q=';

class SearchDao {
  static Future<CommonModel> fetch(String key) async{
    final response = await http.get(API_URL+key);
    if(response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      CommonModel model =  CommonModel.fromJson(result);
      return model;
    } else {
      throw Exception("请求失败");
    }
  }
}