import 'package:flutter/material.dart';
import 'package:meal_app/screens/categories_meal_screens.dart';

class CategoriesItems extends StatefulWidget {
  final String id;
  final String title;
  final Color color;

  CategoriesItems(this.id, this.title, this.color);

  @override
  _CategoriesItemsState createState() => _CategoriesItemsState();
}

class _CategoriesItemsState extends State<CategoriesItems> {
  void selectedCategory(BuildContext ctx) {
    Navigator.of(context).pushNamed(
      CategoriesMealsScreens.routeName,
      arguments: {
        'id' : widget.id,
        'title' : widget.title,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => selectedCategory(context),
        splashColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                widget.color.withOpacity(0.5),
                widget.color,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ));
  }
}
