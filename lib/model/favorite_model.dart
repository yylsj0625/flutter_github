

import 'common_model.dart';

class FavoriteModel {
  final int id;
  final CommonItem model;

  FavoriteModel({this.id, this.model});
  factory FavoriteModel.fromJson(Map<String,dynamic> json){
    int id = json["id"];
    CommonItem model = CommonItem.fromJson(json["model"]);
    return FavoriteModel(
      id: id,
      model: model
    );
  }
  Map<String,dynamic> toJson() {
    Map<String,dynamic> data = new Map<String,dynamic>();
    data["id"] = this.id;
    data["model"] = this.model;
    return data;
  }
}