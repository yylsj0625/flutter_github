import 'package:flutter/material.dart';


class ListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final double size;
  final callback;

  const ListItem({Key key, this.size, this.icon, this.title,this.callback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(callback== null) return;
        callback();
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color:  Color(0xffe2e2e2),
                    width: 0.5,
                    style: BorderStyle.solid
                )
            )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(right: 5),child: _iconItem(context),),
                    Text(title,style: TextStyle(
                        color: Color(0xff888888)
                    ),)
                  ],
                )
            ),
            Icon(
              Icons.keyboard_arrow_right,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
  _iconItem (BuildContext context) {
    return Icon(icon,size: size ?? 14.0,color: Theme.of(context).primaryColor);
  }
}
