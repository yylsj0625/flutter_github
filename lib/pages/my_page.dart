import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/pages/user_page.dart';
import 'package:flutter_app/provider_model/theme_model.dart';
import 'package:flutter_app/utils/commonUtils.dart';
import 'package:flutter_app/widget/list_item.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

import 'custom_key_page.dart';
import 'sort_key_page.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  Animation _opAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    animation = Tween(begin: 1000.0, end: 0.0).animate(controller);
    _opAnimation = Tween(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
//    _loaData();
    return Scaffold(
      appBar: AppBar(
        title: Text('My'),
        centerTitle: true,
      ),
      body: Consumer<ThemeModel>(builder: (context, theme, _) {
        return Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            ListView(
              children: <Widget>[
                ListItem(
                  title: "Yyl GitHub",
                  icon: Icons.toys,
                  size: 50.0,
                  callback: ()=> _navigate("userPage"),
                ),
                _menuItem('Custom trending Language'),
                ListItem(title: "Custom Language", icon: Icons.list),
                ListItem(title: "Custom Language", icon: Icons.import_export),
                _menuItem('Custom popular Language'),
                ListItem(
                    title: "Custom Key",
                    icon: Icons.list,
                    callback: () => _navigate('customKey')),
                ListItem(
                    title: "Sort Key",
                    icon: Icons.import_export,
                    callback: () => _navigate('sortKey')),
                ListItem(
                    title: "Remove Key",
                    icon: Icons.remove,
                    callback: () => _navigate('removeKey')
                ),
                _menuItem('Setting'),
                ListItem(
                  title: "Custom Theme",
                  icon: Icons.view_quilt,
                  callback: () => _themeWidget(theme),
                ),
                ListItem(title: "Night Mode", icon: Icons.brightness_3),
                ListItem(title: "About Author", icon: Icons.insert_emoticon),
              ],
            ),
            Positioned(
                top: animation.value,
                bottom: 0,
                right: 0,
                left: 0,
                child: Opacity(
                  opacity: _opAnimation.value,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        decoration: BoxDecoration(color: Colors.transparent),
                        child: Container(
                          color: Colors.white,
                          child: Wrap(
                            alignment: WrapAlignment.spaceAround,
                            direction: Axis.horizontal,
                            runSpacing: 10,
                            children: _themeList(theme),
                          ),
                        ),
                      )
                    ],
                  ),
                ))
          ],
        );
      }),
    );
  }

  _menuItem(String title) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Color(0xffe5e5e5),
          border: Border(
              bottom: BorderSide(
                  color: Color(0xffe2e2e2),
                  style: BorderStyle.solid,
                  width: 0.5))),
      child: Text(
        title,
        style: TextStyle(fontSize: 12, color: Color(0xff888888)),
      ),
    );
  }

  _navigate(String type) {
    var page;
    switch (type) {
      case "customKey":
        page = CustomKeyPage(type: "customKey",);
        break;
      case "sortKey":
        page = SortPage();
        break;
      case "removeKey":
        page =  CustomKeyPage(type: "removeKey");
        break;
      case "userPage":
        page =  UserPage();
        break;
    }
    Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }

  _themeWidget(ThemeModel theme) {
    controller.forward();
  }

  _themeList(ThemeModel theme) {
    List<Widget> list = [];
    List<Color> colors = CommonUtils.getThemeColor();
    for (int i = 0; i < colors.length; i++) {
      list.add(_colorWidget(colors[i], i, theme));
    }
    return list;
  }

  _colorWidget(Color color, int i, ThemeModel t) {
    return InkWell(
      onTap: () {
        t.changeTheme(i);
        controller.reverse();
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - 20 - 30) / 3,
        height: (MediaQuery.of(context).size.width - 20 - 30) / 3,
        margin: EdgeInsets.all(2),
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}


