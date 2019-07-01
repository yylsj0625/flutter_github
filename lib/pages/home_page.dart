import 'package:flutter/material.dart';
import 'package:flutter_app/pages/favorite_page.dart';
import 'package:flutter_app/pages/my_page.dart';
import 'package:flutter_app/pages/popular_page.dart';
import 'package:flutter_app/pages/search_page.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> with SingleTickerProviderStateMixin{
  List<Widget> pageList = [
    new PopularPage(),
    new SearchPage(),
    new FavoritePage(),
    new MyPage()
  ];
  int _currentIndex = 0;
  PageController _pageController = PageController(initialPage: 0);
  @override
  void initState() {
    super.initState();
    hideScreen();
  }
  Future<void> hideScreen() async {
    Future.delayed(Duration(milliseconds: 3600), () {
      FlutterSplashScreen.hide();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: pageList,
      ),
      bottomNavigationBar:Material(
        color: Theme.of(context).primaryColor,
        child: BottomNavigationBar(
            onTap: (index) {
              _pageController.jumpToPage(index);
              setState(() {
                _currentIndex = index;
              });
            },
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            items: [
              _bottomItem(Icon(Icons.thumb_up), 'Popular'),
              _bottomItem(Icon(Icons.search), 'Search'),
              _bottomItem(Icon(Icons.favorite), 'Favorite'),
              _bottomItem(Icon(Icons.perm_identity), 'My'),
            ]),
      ),
    );
  }

  BottomNavigationBarItem _bottomItem(Icon icon, String text) {
    return BottomNavigationBarItem(
      icon: icon,
      title: Text(text),
    );
  }
}
