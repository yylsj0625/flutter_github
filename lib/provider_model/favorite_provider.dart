
import 'package:flutter/material.dart';
import 'package:flutter_app/model/common_model.dart';
import 'package:flutter_app/model/favorite_model.dart';
import 'dart:convert';
import 'package:flutter_app/utils/commonUtils.dart';

class FavoriteProvider with ChangeNotifier {

  List _list=[];
  List get favList{
   getFavorite();
   List _keyList = [];
   for (FavoriteModel i in _list) {
     if(i.model == null) break;
     _keyList.add(i.model);
   }
   return _keyList;
  }

  changeList (CommonItem model, bool type) async{
    List list = await getFavorite();
    if(type == true) {
      list.add(FavoriteModel(id: model.id,model: model));
    } else if(type == false) {
      List copy = [];
      for (FavoriteModel i in list) {
        if(i.id == model.id) {
          copy.add(i);
        }
      }
      list.removeWhere((e) => copy.contains(e));
    }

    CommonUtils.save('favorites', json.encode(list));
    notifyListeners();
  }
  getFavorite () async {
    String favorite =  await CommonUtils.get("favorites");
    if(favorite == null) return [];
    var keyJson = json.decode(favorite);
    List keyList = keyJson.map((i) => FavoriteModel.fromJson(i)).toList();
    _list = keyList;
    notifyListeners();
    return keyList;
  }
}