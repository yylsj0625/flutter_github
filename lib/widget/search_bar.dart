import 'package:flutter/material.dart';


enum SearchBarType { Popular, Search }
class SearchBar extends StatefulWidget {
  final SearchBarType searchType;
  final rightBtnClick;
  SearchBar({this.searchType,this.rightBtnClick});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _textEditingController = new TextEditingController();
  String key;
  @override
  Widget build(BuildContext context) {
    return _popularSearch();
  }

  _popularSearch() {
    return Container(
      padding: EdgeInsets.fromLTRB(8, MediaQuery.of(context).padding.top, 8, 0),
      height: 55+MediaQuery.of(context).padding.top,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: (){
              if(widget.searchType == SearchBarType.Popular){
                Navigator.pop(context);
              }
            },
            child: _leftBtn(widget.searchType),
          ),
          Expanded(
            child:Container(
              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white70,width: 1,style: BorderStyle.solid))
              ),
              child: TextField(
                onChanged: (String v){
                  setState(() {
                    key = v;
                  });
                },
                controller: _textEditingController,
                autofocus: false,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12
                ),
                cursorColor: Colors.yellow,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 8),
                    hintText: 'Search repos',
                    fillColor: Colors.red,
                    hintStyle: TextStyle(
                      color: Colors.white70,
                      fontSize: 12
                    ),
                    border: InputBorder.none,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              if(_textEditingController.text.trim() == '' ) return false;
              widget.rightBtnClick(key);
            },
            child: Text(  'Go',style: TextStyle(color: Colors.white),),
          )

        ],
      ),
    );
  }
  Widget _leftBtn (SearchBarType type){
    return type == SearchBarType.Search ? Text('Search',style: TextStyle(color: Colors.white),) : Icon(Icons.arrow_back,color: Colors.white);
  }
}

