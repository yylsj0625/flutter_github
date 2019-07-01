class KeysModel {
  String name;
  String shortName;
  bool checked;
  bool delete;

  KeysModel({this.name,this.shortName,this.checked,this.delete});
  factory KeysModel.fromJson(Map<String,dynamic> json) {
  return  KeysModel(
      name: json['name'],
      shortName: json['short_name'],
      checked: json['checked'],
      delete: json['delete']
    );
  }
  Map<String,dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["name"] = this.name;
    data["shortName"] = this.shortName;
    data["checked"] = this.checked;
    data["delete"] = this.delete;
    return data;
  }
}