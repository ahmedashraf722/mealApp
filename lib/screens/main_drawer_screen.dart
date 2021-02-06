import 'package:flutter/material.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/themes_screens.dart';

class MainDrawer extends StatelessWidget {
  Widget _widgetListTile(
      IconData iconData, String text, Function tapHandler, BuildContext ctx) {
    return ListTile(
      leading: Icon(
        iconData,
        size: 26,
        color: Theme.of(ctx).buttonColor,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: Theme.of(ctx).textTheme.bodyText1.color,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'RobotoCondensed',
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Column(
        children: [
          SizedBox(height: 50),
          Container(
            color: Theme.of(context).accentColor,
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: Text(
              "Cooking Up!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(height: 20),
          _widgetListTile(Icons.restaurant, 'Meal', () {
            Navigator.of(context).pushReplacementNamed('/');
          }, context),
          _widgetListTile(Icons.settings, 'Filters', () {
            Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          }, context),
          _widgetListTile(Icons.color_lens, 'Themes', () {
            Navigator.of(context).pushReplacementNamed(ThemesScreen.routeName);
          }, context),
        ],
      ),
    );
  }
}
