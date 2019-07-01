import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_app/provider_model/provider_list.dart';
import 'package:flutter_app/provider_model/theme_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



void main(){
  runApp(
    MultiProvider(
        providers: ProviderList.store(),
      child: MyApp(),
    )
  );
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
        builder: (BuildContext context, theme, _) {
          return MaterialApp(
            title: 'Flutter gitHub',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: theme.theme,
            ),
            home: HomePage(),
          );
        }
    );
  }
}

