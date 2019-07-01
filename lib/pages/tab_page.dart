import 'package:flutter/material.dart';
import 'package:flutter_app/dao/popular_dao.dart';
import 'package:flutter_app/model/common_model.dart';
import 'package:flutter_app/utils/event_bus_util.dart';
import 'package:flutter_app/utils/favorite_list.dart';
import 'package:flutter_app/widget/list_cell.dart';
import 'package:flutter_app/widget/loading_container.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TabPage extends StatefulWidget {
  final String text;
  final Color theme;

  const TabPage({Key key, this.text,this.theme}) : super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with SingleTickerProviderStateMixin {
  List<CommonItem> popularList = [];
  bool _isloading = true;
  @override
  void initState() {
    _handleRefresh();
    super.initState();
  }
  loadData() async {
    try{
      CommonModel model = await PopularDao.fetch(widget.text);
      model.items.forEach((i) async {
        i.isFavorite = await FavoriteList.checkFavorite(i.id);
        if(!mounted) {
          return;
        }
        setState(() {
          _isloading  = false;
          popularList = model.items;
        });
      });
    } catch (e) {
      Fluttertoast.showToast(msg: '数据加载失败！');
    }
  }

  Future<Null> _handleRefresh() async {
    loadData();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5f5),
        body: LoadingContainer(
          isLoading: _isloading,
          child: RefreshIndicator(
              child: ListView.builder(
                  itemCount: popularList.length,
                  itemBuilder: (BuildContext context, int index) {
                    CommonItem model = popularList[index];
                    return Container(
                      padding: EdgeInsets.all(3),
                      child: ListCell(
                        name: model.fullName,
                        desc: model.description,
                        imageUrl: model.owner.avatarUrl,
                        stars: model.stargazersCount,
                        isFavorite: model.isFavorite,
                        model: model,
                      ),
                    );
                  }),
              onRefresh: _handleRefresh
          ),
        )
    );
  }

}
