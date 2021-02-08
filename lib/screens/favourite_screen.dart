import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/widgets/meal_items.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var wd = MediaQuery.of(context).size.width;
    final List<Meal> favouriteMeals = Provider.of<MealProvider>(
      context,
      listen: true,
    ).favouriteMeals;

    if (favouriteMeals.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text(
            lan.getTexts('favorites_text'),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );
    } else {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: wd <= 400 ? 400 : 500,
          childAspectRatio: isLandscape ? wd / (wd * 0.80) : wd / (wd * 0.75),
          crossAxisSpacing: 2,
          mainAxisSpacing: 0.0,
        ),
        itemCount: favouriteMeals.length,
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favouriteMeals[index].id,
            imageUrl: favouriteMeals[index].imageUrl,
            duration: favouriteMeals[index].duration,
            complexity: favouriteMeals[index].complexity,
            affordability: favouriteMeals[index].affordability,
          );
        },
      );
    }
  }
}
