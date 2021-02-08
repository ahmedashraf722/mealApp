import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/widgets/meal_items.dart';
import 'package:provider/provider.dart';

class CategoriesMealsScreens extends StatefulWidget {
  static const routeName = 'category_meals';

  @override
  _CategoriesMealsScreensState createState() => _CategoriesMealsScreensState();
}

class _CategoriesMealsScreensState extends State<CategoriesMealsScreens> {
  String categoryId;
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
    categoryId = routeArg['id'];
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
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var wd = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
           lan.getTexts('cat-$categoryId'),
          ),
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: wd <= 400 ? 400 : 500,
            childAspectRatio: isLandscape ? wd / (wd * 0.80) : wd / (wd * 0.75),
            crossAxisSpacing: 2,
            mainAxisSpacing: 0.0,
          ),
          itemBuilder: (ctx, index) {
            return MealItem(
              id: displayMeals[index].id,
              imageUrl: displayMeals[index].imageUrl,
              duration: displayMeals[index].duration,
              complexity: displayMeals[index].complexity,
              affordability: displayMeals[index].affordability,
            );
          },
          itemCount: displayMeals.length,
        ),
      ),
    );
  }
}
