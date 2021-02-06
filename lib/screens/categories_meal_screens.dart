import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/widgets/meal_items.dart';
import 'package:provider/provider.dart';

class CategoriesMealsScreens extends StatefulWidget {
  static const routeName = 'category_meals';

  @override
  _CategoriesMealsScreensState createState() => _CategoriesMealsScreensState();
}

class _CategoriesMealsScreensState extends State<CategoriesMealsScreens> {
  String categoryTitle;
  List<Meal> displayMeals;

  @override
  void didChangeDependencies() {
    WidgetsFlutterBinding.ensureInitialized();
    final List<Meal> listMeals = Provider.of<MealProvider>(
      context,
      listen: true,
    ).listMeals;
    final routeArg =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryId = routeArg['id'];
    categoryTitle = routeArg['title'];
    displayMeals = listMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  /* void _removeMeal(String mealsId) {
    WidgetsFlutterBinding.ensureInitialized();
    setState(() {
      displayMeals.removeWhere((meal) => meal.id == mealsId);
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          categoryTitle,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayMeals[index].id,
            imageUrl: displayMeals[index].imageUrl,
            title: displayMeals[index].title,
            duration: displayMeals[index].duration,
            complexity: displayMeals[index].complexity,
            affordability: displayMeals[index].affordability,
          );
        },
        itemCount: displayMeals.length,
      ),
    );
  }
}
