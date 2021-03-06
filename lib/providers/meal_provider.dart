import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/models/category.dart';
import 'package:meal_app/models/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MealProvider with ChangeNotifier {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> listMeals = dummyMeals;
  List<Meal> favouriteMeals = [];
  List<String> prefMealId = [];

  List<Category> availableCategory = dummyCategory;

  void setFilters() async {
    WidgetsFlutterBinding.ensureInitialized();
    listMeals = dummyMeals.where((meal) {
      if (filters['gluten'] && !meal.isGlutenFree) {
        return false;
      }
      if (filters['lactose'] && !meal.isLactoseFree) {
        return false;
      }
      if (filters['vegan'] && !meal.isVegan) {
        return false;
      }
      if (filters['vegetarian'] && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    List<Category> ac = [];
    listMeals.forEach((meal) {
      meal.categories.forEach((catId) {
        dummyCategory.forEach((cat) {
          if (cat.id == catId) {
            if (!ac.any((cat) => cat.id == catId)) ac.add(cat);
          }
        });
      });
    });
    availableCategory = ac;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('gluten', filters['gluten']);
    prefs.setBool('lactose', filters['lactose']);
    prefs.setBool('vegan', filters['vegan']);
    prefs.setBool('vegetarian', filters['vegetarian']);
  }

  void getData() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    filters['gluten'] = prefs.getBool('gluten') ?? false;
    filters['lactose'] = prefs.getBool('lactose') ?? false;
    filters['vegan'] = prefs.getBool('vegan') ?? false;
    filters['vegetarian'] = prefs.getBool('vegetarian') ?? false;
    List<String> prefMealId = prefs.getStringList("prefMealId") ?? [];
    for (var mealId in prefMealId) {
      final existingIndex =
          favouriteMeals.indexWhere((meal) => meal.id == mealId);
      if (existingIndex < 0) {
        favouriteMeals.add(dummyMeals.firstWhere((meal) => meal.id == mealId));
      }
    }
    List<Meal> fm = [];
    favouriteMeals.forEach((favMeals) {
      listMeals.forEach((avMeals) {
        if (favMeals.id == avMeals.id) fm.add(avMeals);
      });
    });
    favouriteMeals = fm;

    notifyListeners();
  }

  void toggleFavourite(String mealId) async {
    WidgetsFlutterBinding.ensureInitialized();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final existingIndex =
        favouriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      favouriteMeals.removeAt(existingIndex);
      prefMealId.remove(mealId);
    } else {
      favouriteMeals.add(dummyMeals.firstWhere((meal) => meal.id == mealId));
      prefMealId.add(mealId);
    }

    prefs.setStringList('prefMealId', prefMealId);
    notifyListeners();
  }

  bool isFavourite(String mealId) {
    return favouriteMeals.any((meal) => meal.id == mealId);
  }
}
