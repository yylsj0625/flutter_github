import 'package:flutter_app/model/common_model.dart';

class LocalModel {
  String url;
  int time;
  CommonModel model;

  LocalModel({this.url,this.time,this.model});
  factory LocalModel.fromJson(Map<String,dynamic> json) {
  return  LocalModel(
      url: json['url'],
      time: json['time'],
      model: CommonModel.fromJson(json['model'])
    );
  }
  Map<String,dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["url"] = this.url;
    data["time"] = this.time;
    data["model"] = this.model;
    return data;
  }
}