import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'feed_screen.dart';
import 'categories_screen.dart';
import 'favorites_screen.dart';
import 'settings_screen.dart';


enum _CurrentPage { feed, categories, favorites, settings }

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    required this.index,
  }) : super(key: key);

  final String index;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late _CurrentPage _currentScreen;
  final List<Widget> _screens = [
    const FeedScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentScreen = _CurrentPage.feed;
  }

  _onChangePage(BuildContext context, int index) {
    late _CurrentPage _selected;
    switch (index) {
      case 0:
        _selected = _CurrentPage.feed;
        break;
      case 1:
        _selected = _CurrentPage.categories;
        break;
      case 2:
        _selected = _CurrentPage.favorites;
        break;
      case 3:
        _selected = _CurrentPage.settings;
        break;
      default:
        _selected = _CurrentPage.feed;
    }
    setState(() {
      _currentScreen = _selected;
    });

    final pid = _currentScreen.toString().split('.').last;
    context.goNamed('home', params: {'pid': pid});
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final _router = GoRouter.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[200]!,
      appBar: AppBar(
        title: Text(_router.location),
      ),
      body: _screens[_currentScreen.index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentScreen.index,
        elevation: 0,
        onTap: (index) => _onChangePage(context, index),
        fixedColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[200]!,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
