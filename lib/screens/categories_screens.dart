import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/widgets/categories_items.dart';
import 'package:provider/provider.dart';

class CategoriesScreens extends StatefulWidget {
  @override
  _CategoriesScreensState createState() => _CategoriesScreensState();
}

class _CategoriesScreensState extends State<CategoriesScreens> {
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: GridView(
          padding: EdgeInsets.all(25),
          children: Provider.of<MealProvider>(context, listen: false)
              .availableCategory
              .map(
                (catData) =>
                    CategoriesItems(catData.id, catData.color),
              )
              .toList(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
        ),
      ),
    );
  }
}
