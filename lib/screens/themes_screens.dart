import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/screens/main_drawer_screen.dart';
import 'package:provider/provider.dart';

class ThemesScreen extends StatefulWidget {
  static const routeName = '/themes';

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
    var primaryColor =
        Provider.of<ThemeProvider>(context, listen: true).primaryColor;
    var accentColor =
        Provider.of<ThemeProvider>(context, listen: true).accentColor;

    return ListTile(
      title: Text(
        'Choose your $txt Color',
        style: Theme.of(context).textTheme.headline6,
      ),
      trailing: CircleAvatar(
        backgroundColor: txt == "primary" ? primaryColor : accentColor,
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
                      pickerColor: txt == "primary"
                          ? Provider.of<ThemeProvider>(context, listen: true)
                              .primaryColor
                          : Provider.of<ThemeProvider>(context, listen: true)
                              .accentColor,
                      onColorChanged: (newColor) {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .onChanged(newColor, txt == "primary" ? 1 : 2);
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
    return Scaffold(
      appBar: AppBar(
        title: Text(" Your Themes"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your themes selection.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Choose your Theme Mode :',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                buildRadioListTile(
                  ThemeMode.system,
                  'System Default Theme',
                  Icons.style,
                  context,
                ),
                buildRadioListTile(
                  ThemeMode.light,
                  'Light Theme',
                  Icons.wb_sunny_outlined,
                  context,
                ),
                buildRadioListTile(
                  ThemeMode.dark,
                  'Dark Theme',
                  Icons.nights_stay_sharp,
                  context,
                ),
                buildListTile(context, 'primary'),
                buildListTile(context, 'accent')
              ],
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
