
import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/model/common_model.dart';
import 'package:flutter_app/model/favorite_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteList {
  static Future<List> getFavorite() async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
     String favorite =  prefs.getString("favorites");
     if(favorite == null) return [];
     var keyJson = json.decode(favorite);
     List keyList = keyJson.map((i) => FavoriteModel.fromJson(i)).toList();
     return keyList;
  }
  static save (CommonItem model) async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    try{
      List list = await getFavorite();
      list.add({"id":model.id,"model":model});
      prefs.setString("favorites", json.encode(list));
    } catch(e) {
      throw Exception("fail");
    }
  }
  static checkFavorite(int id) async{
    try{
      List list = await getFavorite();
      for (FavoriteModel i in list) {
        if(i.id == id) {
         return true;
        }
      }
     return false;
    }catch (e) {
      throw Exception(e);
    }
  }
  static remove(int id) async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    List copy = [];
    try{
      List list = await getFavorite();
      for (FavoriteModel i in list) {
        if(i.id == id) {
          copy.add(i);
        }
      }
      list.removeWhere((e) => copy.contains(e));
      prefs.setString("favorites", json.encode(list));
    }catch (e) {
      throw Exception(e);
    }
  }
}