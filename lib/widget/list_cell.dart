import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/model/common_model.dart';
import 'package:flutter_app/pages/search_page.dart';
import 'package:flutter_app/provider_model/favorite_provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_app/widget/webview.dart';
import 'package:provider/provider.dart';

class ListCell extends StatefulWidget {
  String name;
  String desc;
  String imageUrl;
  int stars;
  bool isFavorite;
  CommonItem model;
  ListCell({Key key,this.name,this.desc,this.stars,this.imageUrl,this.isFavorite,this.model}):super(key: key);
  @override
  _ListCellState createState() => _ListCellState();
}

class _ListCellState extends State<ListCell> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(
            builder: (BuildContext context){
          return WebViewPage(url: widget.model.htmlUrl,title: widget.model.name);
        }));
      },
      child: Container(
        margin: EdgeInsets.all(1),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(
                  color: Color(0xffe2e2e2),
                  blurRadius: 2,
                  spreadRadius: 2
              )
            ]
        ),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: _richText(widget.name, Colors.black),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              alignment: Alignment.topLeft,
              child: _richText(widget.desc,Color(0xff666666)),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("Author:",style: TextStyle(color: Color(0xff666666)),),
                      FadeInImage.assetNetwork(
                        placeholder: 'lib/images/popular.png',
                        width: 20,
                        height: 20,
                        image: widget.imageUrl,
                      ),
                    ],
                  ),
                  Text("Stars:${widget.stars}",style: TextStyle(color: Color(0xff666666)),),
                  Consumer<FavoriteProvider>(builder: (context, favorite,_v){
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if(widget.isFavorite == true) {
                            widget.isFavorite = false;
                            widget.model.isFavorite = false;

                          } else {
                            widget.isFavorite = true;
                            widget.model.isFavorite = true;
                          }
                        });
                        favorite.changeList(widget.model,widget.model.isFavorite);
                      },
                      child: Icon(widget.isFavorite == true ? Icons.star : Icons.star_border,color:Theme.of(context).primaryColor),
                    );
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  _richText(String val, Color color) {
    return Text.rich(
      TextSpan(
          children: [
            TextSpan(
                text: val,
              style: TextStyle(
                color: color
              )
            )
          ]
      ),
      textAlign: TextAlign.left,
    );
  }
}
