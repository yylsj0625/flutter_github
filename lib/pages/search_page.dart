import 'package:flutter/material.dart';
import 'package:flutter_app/dao/search_dao.dart';
import 'package:flutter_app/model/common_model.dart';
import 'package:flutter_app/utils/event_bus_util.dart';
import 'package:flutter_app/utils/favorite_list.dart';
import 'package:flutter_app/utils/keys_local.dart';
import 'package:flutter_app/widget/list_cell.dart';
import 'package:flutter_app/widget/loading_container.dart';
import 'package:flutter_app/widget/search_bar.dart';

class SearchPage extends StatefulWidget {
  final SearchBarType type;

  const SearchPage({Key key, this.type = SearchBarType.Search})
      : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin{
  CommonModel model;
  List<CommonItem> commonList;
  String inpKey;
  bool _isBtn = false;
  bool _isLoading = false;
  Animation<double> animation;

  _rightBtnClick(String key) async {
    setState(() {
      _isLoading = true;
    });
   CommonModel _model =  await SearchDao.fetch(key);
    _model.items.forEach((i) async{
           i.isFavorite = await FavoriteList.checkFavorite(i.id);
       });
    setState(() {
      inpKey = key;
        model = _model;
        commonList = _model.items;
        _isLoading = false;
    });
    KeysLocal.checkKey(key).then((res) {
      setState(() {
        _isBtn = res;
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SearchBar(
              searchType: widget.type,
              rightBtnClick: (String key) => _rightBtnClick(key)),
          Expanded(
            child: LoadingContainer(
              isLoading: _isLoading,
              child: commonList?.length == 0 ? _noList() : _hasList(),
            ),
          )
        ],
      ),
    );
  }

  _hasList () {
    return Stack(
      alignment: AlignmentDirectional.topStart,
      overflow: Overflow.clip,
      children: <Widget>[
        MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
                itemCount: commonList?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.all(3),
                    child: ListCell(
                      name: commonList[index].fullName,
                      desc: commonList[index].description,
                      imageUrl: commonList[index].owner.avatarUrl,
                      stars: commonList[index].stargazersCount,
                      isFavorite: commonList[index].isFavorite,
                      model: commonList[index],
                    ),
                  );
                })),
        _addBtn()
      ],
    );
  }
  _noList () {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.sentiment_dissatisfied,size: 50,color: Color.fromRGBO(88, 88, 88, 0.6),),
            Text('查询无结果，请重新输入！',style: TextStyle(
              color: Color.fromRGBO(88, 88, 88, 0.6)
            ),)
          ],
        ),
      ),
    );
  }
  _addBtn() {
    return
      _isBtn == true
        ?
    Positioned(
            bottom: 80,
            left: 30,
            right: 30,
            height: 35,
            child: Material(
                color: Theme.of(context).primaryColor,
                child: InkWell(
                  splashColor: Colors.black12,
                  onTap: () async {
                    bool res =  await KeysLocal.addKey(inpKey);
                    if(res == false) return;
                    eventBus.fire(CommonEvent(isUpdateKeys: true));
                    setState(() {
                      _isBtn = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'add new key:  ',
                            style: TextStyle(color: Colors.white, fontSize: 16)),
                        TextSpan(
                            text: inpKey,
                            style: TextStyle(fontSize: 20, color: Colors.white)),
                      ])),
                    ),
                  ),
                )),
            )
        : Text('');
  }
}
