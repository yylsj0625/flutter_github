import 'package:flutter/material.dart';
import 'package:flutter_app/provider_model/theme_model.dart';
import 'package:provider/provider.dart';

import 'favorite_provider.dart';

class ProviderList {
  static List<SingleChildCloneableWidget> store () {
    return [
      ChangeNotifierProvider(builder: (v) => ThemeModel()),
      ChangeNotifierProvider(builder: (v) => FavoriteProvider()),
    ];
  }
}