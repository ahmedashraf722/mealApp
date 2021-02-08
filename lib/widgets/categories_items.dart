import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/screens/categories_meal_screens.dart';
import 'package:provider/provider.dart';

class CategoriesItems extends StatelessWidget {
  final String id;
  final Color color;

  CategoriesItems(this.id, this.color);

  void selectedCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoriesMealsScreens.routeName,
      arguments: {
        'id': id,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return InkWell(
      onTap: () => selectedCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.5),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          lan.getTexts('cat-$id'),
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
