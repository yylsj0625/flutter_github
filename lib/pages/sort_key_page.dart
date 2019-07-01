import 'package:flutter/material.dart';
import 'package:flutter_app/provider_model/theme_model.dart';
import 'package:flutter_app/utils/keys_local.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class SortPage extends StatefulWidget {
  @override
  _SortPageState createState() => _SortPageState();
}

class _SortPageState extends State<SortPage> {
  List list = [];
  List  allList = [];
  String keys;
  String saveKeys;
  String allSaveKeys;
  bool _isSave = false;

  @override
  void initState() {
    // TODO: implement initState
    _loadKey();
    super.initState();
  }

  _loadKey () async {
   List _list = await KeysLocal.fetchKeys('keys');
   allList = await KeysLocal.fetchKeys('allKeys');
   setState(() {
     list = _list;
   });
   keys = json.encode(list);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Sort Key'),
            centerTitle: true,
            actions: <Widget>[
              InkWell(
                onTap: () {
                  if(_isSave) {
                    KeysLocal.save('allKeys',allSaveKeys);
                  }
                  Navigator.pop(context);
                },
                child:Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Center(
                    child: Text('Save'),
                  ),
                ),
              )
            ],
          ),
          body: Center(
            child: ReorderableListView(
              children: _reorderListWidget(),
              onReorder: _onReorder,
            ),
          ),
        ),
        onWillPop:()=> _willPop()
    );
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
               KeysLocal.save('allKeys',allSaveKeys);
               Navigator.of(context).pop();
               Navigator.pop(context);
             },
             child: new Text('确定'))
       ]);
     },
   );
 }
  Future<bool> _willPop () {
   if(_isSave) {
     _showDialog();
   } else {
     Navigator.pop(context);
   }
    return Future.value(false);
  }
  _reorderListWidget () {
    List<Widget> _list = [];
    list.forEach((i){
      _list.add(_reorderItem(i.name));
    });
    return _list;
  }
  _reorderItem(String title) {
    return InkWell(
      key: ObjectKey(title),
      child: Container(
        padding: EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey,width: 0.3,style: BorderStyle.solid))
        ),
        child: Row(
          children: <Widget>[
            Consumer<ThemeModel>(builder: (context,ThemeModel theme,_){
              return Icon(Icons.menu,color: theme.theme,size: 14,);
            },),
            Container(
              padding: EdgeInsets.fromLTRB(5, 10, 0, 10),
              child: Text(title),
            )
          ],
        ),
      ),
    );
  }

  _onReorder(int oldIndex, int newIndex){
    print('oldIndex: $oldIndex , newIndex: $newIndex');
    setState(() {
      if (newIndex == list.length){
        newIndex = list.length - 1;
      }
      int _newId = allList.indexWhere((i) => i.name == list[newIndex].name);
      int _oldId = allList.indexWhere((i) => i.name == list[oldIndex].name);
      print(_oldId);
      var _item = allList.removeAt(_oldId);
      print(_item);
      allList.insert(_newId,  _item);
      var item = list.removeAt(oldIndex);
      list.insert(newIndex, item);
      saveKeys = json.encode(list);
      allSaveKeys = json.encode(allList);
      _isSave = keys != saveKeys;
    });
  }
}
