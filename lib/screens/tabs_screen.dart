import 'package:flutter/material.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/screens/categories_screens.dart';
import 'package:meal_app/screens/favourite_screen.dart';
import 'package:meal_app/screens/main_drawer_screen.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;

  int _selectedIndexPages = 0;

  @override
  void initState() {
    Provider.of<MealProvider>(
      context,
      listen: false,
    ).getData();
    Provider.of<ThemeProvider>(
      context,
      listen: false,
    ).getThemeMode();
    Provider.of<ThemeProvider>(
      context,
      listen: false,
    ).getThemeColors();
    _pages = [
      {
        'page': CategoriesScreens(),
        'title': 'Categories',
      },
      {
        'page': FavouriteScreen(),
        'title': 'Your Favourites',
      },
    ];
    super.initState();
  }

  void _selectedPage(int value) {
    setState(() {
      _selectedIndexPages = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedIndexPages]['title']),
      ),
      body: _pages[_selectedIndexPages]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndexPages,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favourites",
          ),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
