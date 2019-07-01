import 'package:flutter/material.dart';
import 'package:flutter_app/model/keys_model.dart';
import 'dart:convert';
import 'package:flutter_app/utils/keys_local.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomKeyPage extends StatefulWidget {
  final String type;

  const CustomKeyPage({Key key, this.type}) : super(key: key);
  @override
  _CustomKeyPageState createState() => _CustomKeyPageState();
}

class _CustomKeyPageState extends State<CustomKeyPage> {
  List list = [];
  String keys;
  String saveKeys;
  bool _isSave = false;

  @override
  void initState() {
    // TODO: implement initState
    _loadKey();
    super.initState();
  }

  _loadKey() async {
    List _list = await KeysLocal.fetchKeys('allKeys');
    setState(() {
      list = _list;
    });
    keys = json.encode(list);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.type),
            centerTitle: true,
            actions: <Widget>[
              InkWell(
                onTap: () {
                  if (_isSave) {
                   if(_saveKey()){
                     Navigator.pop(context);
                   }
                  }
                },
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Center(
                    child: Text('Save'),
                  ),
                ),
              )
            ],
          ),
          body: GridView.builder(
              itemCount: list.length,
              padding: EdgeInsets.all(0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 3.0),
              itemBuilder: (BuildContext context, int index) {
                return _checkItem(list[index], index);
              }),
        ),
        onWillPop: () => _willPop());
  }

  _checkItem(KeysModel model , int i) {
    return InkWell(
      onTap: () {
        _change(i, widget.type == 'customKey' ? !model.checked : !model.delete);
      },
      child: Row(
        children: <Widget>[
          Checkbox(
              value: widget.type == 'customKey' ? model.checked : model.delete,
              onChanged: (bool val) {
                _change(i, val);
              }),
          Text(model.name)
        ],
      ),
    );
  }

  _change(int i, bool val) {
    setState(() {
      if(widget.type == 'customKey'){
        list[i].checked = val;
        saveKeys = json.encode(list);
      } else {
        list[i].delete = val;
        saveKeys = json.encode(list);
      }
    });
    _isSave = keys != saveKeys;
  }

  _showDialog() {
    showDialog<Null>(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
            title: Text('确认退出'),
            content: new Text('是否保存当前操作？'),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pop(context);
                  },
                  child: new Text('取消')),
              new FlatButton(
                  onPressed: () {
                    if(_saveKey()){
                      Navigator.of(context).pop();
                      Navigator.pop(context);
                    }else {
                      Navigator.pop(context);
                    }

                  },
                  child: new Text('确定'))
            ]);
      },
    );
  }

 bool _saveKey () {
    if(widget.type == 'customKey') {
      int num= 0;
      for(int i=0; i<list.length; i++ ){
        if(list[i].checked){
          num++;
        }
      }
      if(num < 3) {
        Fluttertoast.showToast(msg: "最少需要保留3个");
        return false;
      }
      KeysLocal.save('allKeys',saveKeys);
    } else {
      int num= 0;
      for(int i=0; i<list.length; i++ ){
        if(list[i].delete){
          num++;
        }
      }
      if(num < 3) {
        Fluttertoast.showToast(msg: "最少需要保留3个");
        return false;
      }
      list.removeWhere((i) => !i.delete);
      KeysLocal.save('allKeys',json.encode(list));
    }
    return true;
  }
  Future<bool> _willPop() {
    if (_isSave) {
      _showDialog();
    } else {
      Navigator.pop(context);
    }
    return Future.value(false);
  }
}
