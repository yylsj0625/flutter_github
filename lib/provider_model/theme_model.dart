import 'package:flutter/material.dart';
import 'package:flutter_app/utils/commonUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModel  with ChangeNotifier {
  Color _theme;
  int _currentIndex;


  int get currentIndex {
    return _currentIndex;
}
  Color get theme{
    getTheme();
    return _theme;
  }
  
  void changeTheme (int index) {
    _theme = CommonUtils.getThemeColor()[index];
    CommonUtils.save('theme', index.toString());
    notifyListeners();
  }

  // 获取本地颜色
  getTheme () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var theme = prefs.getString('theme');
    if(theme == null) {
      _theme = CommonUtils.getThemeColor()[1];
      _currentIndex = 1;
    } else {
     String index =  await CommonUtils.get('theme');
      _theme = CommonUtils.getThemeColor()[int.parse(index)];
      _currentIndex = int.parse(index);
    }
    notifyListeners();
  }
}