import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/screens/main_drawer_screen.dart';
import 'package:provider/provider.dart';

class ThemesScreen extends StatefulWidget {
  static const routeName = '/themes';
  final bool fromOnBoarding;

  ThemesScreen({this.fromOnBoarding = false});

  @override
  _ThemesScreenState createState() => _ThemesScreenState();
}

class _ThemesScreenState extends State<ThemesScreen> {
  Widget buildRadioListTile(
    ThemeMode themeVal,
    String txt,
    IconData iconData,
    BuildContext ctx,
  ) {
    return RadioListTile(
      title: Text(
        txt,
        style: Theme.of(context).textTheme.headline6,
      ),
      secondary: Icon(iconData, color: Theme.of(ctx).buttonColor),
      value: themeVal,
      onChanged: (newThemeValue) {
        Provider.of<ThemeProvider>(ctx, listen: false)
            .themeModeChange(newThemeValue);
      },
      groupValue: Provider.of<ThemeProvider>(ctx, listen: true).tm,
    );
  }

  ListTile buildListTile(BuildContext ctx, txt) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    var primaryColor =
        Provider.of<ThemeProvider>(context, listen: true).primaryColor;
    var accentColor =
        Provider.of<ThemeProvider>(context, listen: true).accentColor;

    return ListTile(
      title: Text(
        '$txt',
        style: Theme.of(context).textTheme.headline6,
      ),
      trailing: CircleAvatar(
        backgroundColor:
            txt == lan.getTexts('primary') ? primaryColor : accentColor,
      ),
      onTap: () {
        setState(
          () {
            showDialog(
              context: context,
              builder: (BuildContext ctx) {
                return AlertDialog(
                  elevation: 4,
                  titlePadding: EdgeInsets.all(0.0),
                  contentPadding: EdgeInsets.all(0.0),
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      pickerColor: txt == lan.getTexts('primary')
                          ? Provider.of<ThemeProvider>(context, listen: true)
                              .primaryColor
                          : Provider.of<ThemeProvider>(context, listen: true)
                              .accentColor,
                      onColorChanged: (newColor) {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .onChanged(newColor,
                                txt == lan.getTexts('primary') ? 1 : 2);
                      },
                      colorPickerWidth: 300.0,
                      pickerAreaHeightPercent: 0.7,
                      enableAlpha: false,
                      displayThumbColor: true,
                      showLabel: false,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            title: widget.fromOnBoarding
                ? null
                : Text(lan.getTexts('theme_appBar_title')),
            backgroundColor: widget.fromOnBoarding
                ? Theme.of(context).canvasColor
                : Theme.of(context).primaryColor,
            elevation: widget.fromOnBoarding ? 0 : 5,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    lan.getTexts('theme_screen_title'),
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    lan.getTexts('theme_mode_title'),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                buildRadioListTile(
                  ThemeMode.system,
                  lan.getTexts('System_default_theme'),
                  Icons.style,
                  context,
                ),
                buildRadioListTile(
                  ThemeMode.light,
                  lan.getTexts('light_theme'),
                  Icons.wb_sunny_outlined,
                  context,
                ),
                buildRadioListTile(
                  ThemeMode.dark,
                  lan.getTexts('dark_theme'),
                  Icons.nights_stay_sharp,
                  context,
                ),
                buildListTile(context, lan.getTexts('primary')),
                buildListTile(context, lan.getTexts('accent')),
                SizedBox(height: widget.fromOnBoarding ? 80 : 0),
              ],
            ),
          ),
        ],
      ),
      drawer: widget.fromOnBoarding ? null : MainDrawer(),
    );
  }
}
