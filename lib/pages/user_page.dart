import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/user_item.dart';
import 'package:flutter_app/widget/webview.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "YylGitHub",
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0.0,
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            EasyRefresh(
              behavior: ScrollOverBehavior(),
              child: ListView(
                padding: const EdgeInsets.all(0.0),
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  // 顶部栏
                  new Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 220.0,
                        color: Colors.white,
                      ),
                      ClipPath(
                        clipper: new TopBarClipper(
                            MediaQuery.of(context).size.width, 200.0),
                        child: new SizedBox(
                          width: double.infinity,
                          height: 200.0,
                          child: new Container(
                            width: double.infinity,
                            height: 240.0,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      // 名字
                      Container(
                        margin: new EdgeInsets.only(top: 40.0),
                        child: new Center(
                          child: new Text(
                            "Yyl",
                            style: new TextStyle(
                                fontSize: 30.0, color: Colors.white),
                          ),
                        ),
                      ),
                      // 图标
                      Container(
                        margin: new EdgeInsets.only(top: 100.0),
                        child: new Center(
                            child: new Container(
                              width: 100.0,
                              height: 100.0,
                              child: new PreferredSize(
                                child: new Container(
                                  child: new ClipOval(
                                    child: new Container(
                                      color: Colors.white,
                                      child:
                                      new Image.asset("lib/images/user.jpg"),
                                    ),
                                  ),
                                ),
                                preferredSize: new Size(80.0, 80.0),
                              ),
                            )),
                      ),
                    ],
                  ),
                  // 内容
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: EdgeInsets.all(10.0),
                    child: Card(
                        color: Colors.blue,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              UserItem(
                                icon: Icon(
                                  Icons.format_list_numbered,
                                  color: Colors.white,
                                ),
                                title:"简书",
                                titleColor: Colors.white,
                                describe: "https://www.jianshu.com/u/d3d880e7e01b",
                                describeColor: Colors.white,
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(
                                      builder: (BuildContext context){
                                        return WebViewPage(url: 'https://www.jianshu.com/u/d3d880e7e01b',title: "奋斗的小蜗牛yyl");
                                      }));
                                },
                              ),
                              UserItem(
                                icon: Icon(
                                  Icons.web,
                                  color: Colors.white,
                                ),
                                title: "github",
                                titleColor: Colors.white,
                                describe: "https://github.com/yylsj0625",
                                describeColor: Colors.white,
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(
                                      builder: (BuildContext context){
                                        return WebViewPage(url: 'https://github.com/yylsj0625',title: "yylsj0625");
                                      }));
                                },
                              )
                            ],
                          ),
                        )),
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: EdgeInsets.all(10.0),
                    child: Card(
                        color: Colors.green,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              UserItem(
                                icon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                title: "name",
                                titleColor: Colors.white,
                                describe: "Yyl",
                                describeColor: Colors.white,
                              ),
                              UserItem(
                                icon: EmptyIcon(),
                                title:"old",
                                titleColor: Colors.white,
                                describe:"sj",
                                describeColor: Colors.white,
                              ),
                              UserItem(
                                icon: EmptyIcon(),
                                title: "city",
                                titleColor: Colors.white,
                                describe:"shanghai",
                                describeColor: Colors.white,
                              )
                            ],
                          ),
                        )),
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: EdgeInsets.all(10.0),
                    child: Card(
                        color: Colors.teal,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              UserItem(
                                icon: Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                ),
                                title: "phone",
                                titleColor: Colors.white,
                                describe: "18888888888",
                                describeColor: Colors.white,
                              ),
                              UserItem(
                                icon: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                                title: "email",
                                titleColor: Colors.white,
                                describe: "xxxxxxxxx",
                                describeColor: Colors.white,
                                onPressed: () {

                                },
                              )
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
class TopBarClipper extends CustomClipper<Path> {
  // 宽高
  double width;
  double height;

  TopBarClipper(this.width, this.height);

  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.moveTo(0.0, 0.0);
    path.lineTo(width, 0.0);
    path.lineTo(width, height / 2);
    path.lineTo(0.0, height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}