import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonUtils {
  static List<Color> getThemeColor() {
    return [
      Colors.red,
      Colors.pink,
      Colors.blue,
      Colors.teal,
      Colors.amber,
      Colors.blueGrey,
      Colors.deepOrange,
      Colors.purple,
      Colors.indigo,
      Colors.cyan,
      Colors.yellow,
      Colors.green,
    ];
  }
  static save(String key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  static remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}