import 'package:flutter/material.dart';
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
    final Map<String, bool> currentFilters = Provider.of<MealProvider>(
      context,
      listen: true,
    ).filters;
    return Scaffold(
      appBar: AppBar(
        title: Text(" Your Filters"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal Selection.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTile(
                  "Gluten-free",
                  "Only include gluten-free meals",
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
                  "Lactose-Free",
                  "Only include Lactose-Free meals",
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
                  "Vegetarian",
                  "Only include vegetarian meals",
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
                  "Vegan",
                  "Only include Vegan meals",
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
