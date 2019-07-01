import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/keys_model.dart';
import 'package:flutter_app/model/common_model.dart';
import 'package:flutter_app/pages/search_page.dart';
import 'package:flutter_app/pages/tab_page.dart';
import 'package:flutter_app/provider_model/theme_model.dart';
import 'package:flutter_app/utils/keys_local.dart';
import 'package:flutter_app/widget/loading_container.dart';
import 'package:flutter_app/widget/search_bar.dart';
import 'package:provider/provider.dart';

class PopularPage extends StatefulWidget {
  @override
  _PopularPageState createState() => _PopularPageState();
}

class _PopularPageState extends State<PopularPage>
    with TickerProviderStateMixin {
  CommonModel response;

  TabController _tabController;
  List keyList=[];
  List keyJson;
  bool _isLoading = true;
  var that;

  @override
  void initState() {
    _reloadJson();
    super.initState();
  }
  _reloadJson() async {
    Future<List> keys = KeysLocal.fetchKeys('keys');
    keys.then((res){
      if(res == null){
        Future<String> keysJson =
        DefaultAssetBundle.of(context).loadString("lib/data/keys.json");
         keysJson.then((res) {
          KeysLocal.save('allKeys',res);
          keyJson = json.decode(res);
          List list = keyJson.map((i) => KeysModel.fromJson(i)).toList();
          _setData(list);
        });
      } else {
        _setData(res);
    }
    });
    return false;
  }

  _setData (List val) {
    setState(() {
      keyList = val;
      _tabController = TabController(length: keyList.length,initialIndex: 0, vsync: this);
      _isLoading = false;
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('popular'),
        actions: [
          GestureDetector(
            child: Padding(
                padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.search),
            ),
            onTap: (){
              Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context){
                return SearchPage(type:SearchBarType.Popular,);
              })).then((res) {
                // 监听路由返回回调
                _reloadJson();
              });
            },
          ),
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body:LoadingContainer(
        isLoading: _isLoading,
        child:keyList?.length == 0  ? Text('') : Column(
          children: <Widget>[
            Consumer<ThemeModel>(
              builder: (context,theme,_){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      flex:1,
                        child: Container(
                      decoration: BoxDecoration(
                        color: theme.theme,
                      ),
                      child: TabBar(
                          indicatorColor: Colors.white,
                          unselectedLabelColor:Colors.white,
                          unselectedLabelStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                          isScrollable: true,
                          controller: _tabController,
                          tabs: _tabs(keyList)),
                    )),

                  ],
                );
              },
            ),
            Flexible(
              child: TabBarView(
                  controller: _tabController,
                  children: keyList.map((i) {
                    return TabPage(text: i.name,theme: Colors.pink);
                  }).toList()),
            ),
          ],
        ),
      ),
    );
  }

  _tabs(List list) {
    List<Widget> tabList = [];
    if (list == null) {
      tabList.add(_tabItem(''));
      return tabList;
    }
    list.forEach((res) {
      tabList.add(_tabItem(res.name));
    });
    return tabList;
  }

  Tab _tabItem(String name) {
    return Tab(
      text: name,
    );
  }
}

