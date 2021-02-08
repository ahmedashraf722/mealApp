import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';

class MealDetailsScreen extends StatefulWidget {
  static const routeName = 'meal_details';

  @override
  _MealDetailsScreenState createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  Widget buildSectionTitles(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var wd = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Container(
      height: isLandscape ? h * 0.5 : h * 0.25,
      width: isLandscape ? (wd * 0.5 - 30) : wd,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey)),
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(10),
      child: child,
    );
  }

  /* void _removeItemS(String r) {
    Navigator.of(context).pop(r);
  }*/

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = dummyMeals.firstWhere((meal) => meal.id == mealId);
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    List<String> listS = lan.getTexts('steps-$mealId') as List<String>;
    var listSteps = ListView.builder(
      padding: EdgeInsets.all(0.0),
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                child: Text("${index + 1}"),
              ),
              title: Text(listS[index]),
            ),
            Divider(),
          ],
        );
      },
      itemCount: listS.length,
    );
    List<String> listG = lan.getTexts('ingredients-$mealId') as List<String>;
    var gridIngredients = ListView.builder(
      padding: EdgeInsets.all(0.0),
      itemBuilder: (context, index) {
        return Card(
          color: Theme.of(context).accentColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            child: Text(listG[index]),
          ),
        );
      },
      itemCount: listG.length,
    );

    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(lan.getTexts('meal-$mealId')),
                background: Hero(
                  tag: mealId,
                  child: InteractiveViewer(
                    child: FadeInImage(
                      image: NetworkImage(
                        selectedMeal.imageUrl,
                      ),
                      placeholder: AssetImage("assets/images/a2.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  if (isLandscape)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            buildSectionTitles(
                                context, lan.getTexts('Ingredients')),
                            buildContainer(gridIngredients),
                          ],
                        ),
                        Column(
                          children: [
                            buildSectionTitles(context, lan.getTexts('Steps')),
                            buildContainer(listSteps),
                          ],
                        ),
                      ],
                    ),
                  if (!isLandscape)
                    buildSectionTitles(context, lan.getTexts('Ingredients')),
                  if (!isLandscape) buildContainer(gridIngredients),
                  if (!isLandscape)
                    buildSectionTitles(context, lan.getTexts('Steps')),
                  if (!isLandscape) buildContainer(listSteps),
                  SizedBox(height: 25),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          key: _formKey,
          onPressed: () {
            setState(() {
              Provider.of<MealProvider>(
                context,
                listen: false,
              ).toggleFavourite(mealId);
            });
          },
          child: Icon(Provider.of<MealProvider>(
            context,
            listen: true,
          ).isFavourite(mealId)
              ? Icons.star
              : Icons.star_border_outlined),
        ),
      ),
    );
  }
}
