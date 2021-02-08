import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/screens/main_drawer_screen.dart';
import 'package:provider/provider.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  Widget buildSwitchListTile(
    String title,
    String dec,
    bool currentValue,
    Function updateValue,
  ) {
    return SwitchListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
      subtitle: Text(
        dec,
        style: Theme.of(context).textTheme.headline6,
      ),
      value: currentValue,
      onChanged: updateValue,
      inactiveTrackColor:
          Provider.of<ThemeProvider>(context, listen: true).tm ==
                  ThemeMode.light
              ? null
              : Colors.black87,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    final Map<String, bool> currentFilters = Provider.of<MealProvider>(
      context,
      listen: true,
    ).filters;
    return Scaffold(
      appBar: AppBar(
        title: Text(lan.getTexts('filters_appBar_title')),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              lan.getTexts('filters_screen_title'),
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTile(
                 lan.getTexts('Gluten-free'),
                  lan.getTexts('Gluten-free-sub'),
                  currentFilters['gluten'],
                  (newValue) {
                    setState(() {
                      currentFilters['gluten'] = newValue;
                    });
                    Provider.of<MealProvider>(
                      context,
                      listen: false,
                    ).setFilters();
                  },
                ),
                buildSwitchListTile(
                  lan.getTexts('Lactose-free'),
                  lan.getTexts('Lactose-free_sub'),
                  currentFilters['lactose'],
                  (newValue) {
                    setState(() {
                      currentFilters['lactose'] = newValue;
                    });
                    Provider.of<MealProvider>(
                      context,
                      listen: false,
                    ).setFilters();
                  },
                ),
                buildSwitchListTile(
                  lan.getTexts('Vegetarian'),
                  lan.getTexts('Vegetarian-sub'),
                  currentFilters['vegetarian'],
                  (newValue) {
                    setState(() {
                      currentFilters['vegetarian'] = newValue;
                    });
                    Provider.of<MealProvider>(
                      context,
                      listen: false,
                    ).setFilters();
                  },
                ),
                buildSwitchListTile(
                 lan.getTexts('Vegan'),
                  lan.getTexts('Vegan-sub'),
                  currentFilters['vegan'],
                  (newValue) {
                    setState(() {
                      currentFilters['vegan'] = newValue;
                    });
                    Provider.of<MealProvider>(
                      context,
                      listen: false,
                    ).setFilters();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
