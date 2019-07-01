import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_app/model/common_model.dart';
import 'package:flutter_app/model/keys_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
class KeysLocal {
  static Future<List> fetchKeys(String type) async{
   return await _getKey(type);
  }
  static save (String key,String keys) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, keys);
  }
  static _getKey(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var keyVal =  prefs.getString('allKeys');
    if(keyVal == null) return null;
    var keyJson = json.decode(keyVal);
    List _keyList = keyJson.map((i) => KeysModel.fromJson(i)).toList();
    if(key == 'keys') {
      _keyList.removeWhere((i) => i.checked == false);
    }
    return _keyList;
  }
  static Future<bool> checkKey(String key) async{
    bool flag = true;
    List allList = await fetchKeys("allKeys");
      for(var i in allList) {
        String name = i.name;
        if(name.toUpperCase() == key.toUpperCase()) {
          flag =  false;
          break;
        }
      }
    return flag;
  }
  static addKey (String key) async{
    bool flag = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool res = await checkKey(key);
    if(res == false) {
      Fluttertoast.showToast(msg: "$key 已经存在！");
      return false;
    }
    _addKey("allKeys",key);
    Fluttertoast.showToast(msg: "$key 添加成功！");
    return flag;
  }
  static _addKey(String type,String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List list = await fetchKeys(type);
    list.add(KeysModel(name: key,shortName: key,checked: true,delete: true));
    prefs.setString(type, json.encode(list));
  }
}