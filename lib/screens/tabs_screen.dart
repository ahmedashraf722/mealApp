import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
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
    Provider.of<LanguageProvider>(
      context,
      listen: false,
    ).getLan();
    super.initState();
  }

  void _selectedPage(int value) {
    setState(() {
      _selectedIndexPages = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    _pages = [
      {
        'page': CategoriesScreens(),
        'title': lan.getTexts('categories'),
      },
      {
        'page': FavouriteScreen(),
        'title': lan.getTexts('your_favorites'),
      },
    ];
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
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
              label: lan.getTexts('categories'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: lan.getTexts('your_favorites'),
            ),
          ],
        ),
        drawer: MainDrawer(),
      ),
    );
  }
}
