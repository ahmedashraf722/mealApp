import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/screens/meal_details_screens.dart';
import 'package:provider/provider.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  MealItem({
    @required this.id,
    @required this.imageUrl,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
  });

  void selectedMeal(BuildContext ctx) {
    WidgetsFlutterBinding.ensureInitialized();
    Navigator.of(ctx).pushNamed(
      MealDetailsScreen.routeName,
      arguments: id,
    );
    /*.then((result) {
       if (result != null) {
        setState(() {
         // widget.removeItem(result);
        });
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    TextStyle textStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: Theme.of(context).primaryColor,
      fontSize: 14,
    );

    return InkWell(
      onTap: () => selectedMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Hero(
                    tag: id,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      lan.getTexts('meal-$id'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.alarm_on_outlined,
                        color: Theme.of(context).buttonColor,
                      ),
                      SizedBox(width: 4),
                      if (duration <= 10)
                        Text("$duration" + lan.getTexts('min2'),
                            style: textStyle),
                      if (duration > 10)
                        Text("$duration" + lan.getTexts('min'),
                            style: textStyle),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.work,
                        color: Theme.of(context).buttonColor,
                      ),
                      SizedBox(width: 4),
                      Text(lan.getTexts('$complexity'), style: textStyle),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.attach_money,
                        color: Theme.of(context).buttonColor,
                      ),
                      SizedBox(width: 4),
                      Text(lan.getTexts('$affordability'), style: textStyle),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
