import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NavigatorUtil {
  static materialRoute(BuildContext context, T){
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
      return T;
    }));
  }
  static cupertinoRoute(BuildContext context, T,{callback}){
    Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context){
      return T;
    })).then((v)=> callback(v));
  }
}