import 'package:flutter/material.dart';
import 'package:flutter_app/model/common_model.dart';
import 'package:flutter_app/provider_model/favorite_provider.dart';
import 'package:flutter_app/widget/list_cell.dart';
import 'package:flutter_app/widget/loading_container.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List favoriteList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('favorite'),
        centerTitle: true,
      ),
      body: Consumer<FavoriteProvider>(
          builder: (context, favorite,_) {
            return  Column(
              children: <Widget>[
                Expanded(
                  child: LoadingContainer(
                    isLoading: false,
                    child: favorite.favList?.length == 0 ? _noList() : _hasList(favorite.favList),
                  ),
                )
              ],
            );
          }
      ),
    );
  }

  _hasList(List list) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
            itemCount: list == null ? 0 : list.length,
            itemBuilder: (BuildContext context, int index) {
              CommonItem model = list[index];
              return Container(
                margin: EdgeInsets.all(3),
                child: ListCell(
                  name: model.fullName,
                  desc: model.description,
                  imageUrl: model.owner.avatarUrl,
                  stars: model.stargazersCount,
                  isFavorite: model.isFavorite,
                  model: model,
                ),
              );
            })
    );
  }

  _noList() {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.sentiment_very_satisfied,
              size: 50,
              color: Color.fromRGBO(88, 88, 88, 0.6),
            ),
            Text(
              '还没有喜欢的项目哦，快去添加吧！',
              style: TextStyle(color: Color.fromRGBO(88, 88, 88, 0.6)),
            )
          ],
        ),
      ),
    );
  }
}
