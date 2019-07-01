import 'dart:async';
import 'dart:convert';
import "package:flutter_app/model/common_model.dart";
import 'package:flutter_app/model/local_model.dart';
import 'package:flutter_app/utils/commonUtils.dart';
import 'package:http/http.dart' as http;

const POPULAR_URL = "https://api.github.com/search/repositories?q=";
const QUERY_KEY = "&sort=stars";

class PopularDao {
  static Future<CommonModel> fetch(String key) async {
    String url = POPULAR_URL + key + QUERY_KEY;
    CommonModel model;
    var res = await fetchLocal(url);
    if(res == false) {
      model = await fetchNet(url);
    } else {
      model = res;
    }
    return model;
  }
  static fetchNet (String url) async{
    final response = await http.get(url);
    if(response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      CommonModel model =  CommonModel.fromJson(result);
      save(url, model);
      return model;
    } else {
      throw Exception('请求失败');
    }
  }
  static fetchLocal (String url) async{
    var res = await CommonUtils.get(url);
    if(res ==null) {
      return false;
    } else {
      LocalModel _model = LocalModel.fromJson(jsonDecode(res));
      if(checkTime(_model.time) == true){
        return false;
      } else {
        CommonModel data = _model.model;
        return data;
      }
    }
  }
  static save(String url,CommonModel val) {
    int time = DateTime.now().day;
    String data = jsonEncode(LocalModel(url: url,time: time,model: val));
    CommonUtils.save(url, data);
  }
  static checkTime (int time) {
    int _currentTime = DateTime.now().day;
    return _currentTime - time > 3;
  }
}