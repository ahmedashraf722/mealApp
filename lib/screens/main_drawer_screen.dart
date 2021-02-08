import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/themes_screens.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  Widget _widgetListTile(
      IconData iconData, String text, Function tapHandler, BuildContext ctx) {
    return ListTile(
      leading: Icon(
        iconData,
        size: 26,
        color: Theme.of(ctx).buttonColor,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: Theme.of(ctx).textTheme.bodyText1.color,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'RobotoCondensed',
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Drawer(
        elevation: 0,
        child: ListView(
          children: [
            Container(
              color: Theme.of(context).accentColor,
              height: 120,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              alignment:
                  lan.isEn ? Alignment.centerLeft : Alignment.centerRight,
              child: Text(
                lan.getTexts('drawer_name'),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(height: 15),
            _widgetListTile(Icons.restaurant, lan.getTexts('drawer_item1'), () {
              Navigator.of(context).pushReplacementNamed('/');
            }, context),
            _widgetListTile(Icons.settings, lan.getTexts('drawer_item2'), () {
              Navigator.of(context)
                  .pushReplacementNamed(FiltersScreen.routeName);
            }, context),
            _widgetListTile(Icons.color_lens, lan.getTexts('drawer_item3'), () {
              Navigator.of(context)
                  .pushReplacementNamed(ThemesScreen.routeName);
            }, context),
            Divider(
              height: 10,
              color: Colors.black54,
            ),
            SizedBox(height: 10),
            Padding(
              padding: lan.isEn
                  ? EdgeInsets.only(left: 5)
                  : EdgeInsets.only(right: 5),
              child: Text(
                lan.getTexts('drawer_switch_title'),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
              padding: lan.isEn
                  ? EdgeInsets.only(left: 5)
                  : EdgeInsets.only(right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    lan.getTexts('drawer_switch_item2'),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Switch(
                    value: Provider.of<LanguageProvider>(context, listen: true)
                        .isEn,
                    onChanged: (newValue) {
                      Provider.of<LanguageProvider>(context, listen: false)
                          .changeLan(newValue);
                      Navigator.of(context).pop();
                    },
                    activeColor:
                        Provider.of<ThemeProvider>(context).primaryColor,
                    inactiveThumbColor:
                        Provider.of<ThemeProvider>(context).primaryColor,
                  ),
                  Text(
                    lan.getTexts('drawer_switch_item1'),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ),
            Divider(
              height: 10,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}
