import 'package:flutter/foundation.dart';
import '../models/meal.dart';

class MealService extends ChangeNotifier {
  final List<Meal> _favoriteMeals = [];

  List<Meal> get favorites => List.unmodifiable(_favoriteMeals);

  bool isFavorite(Meal meal) {
    return _favoriteMeals.any((m) => m.idMeal == meal.idMeal);
  }

  void toggleFavorite(Meal meal) {
    final exists = isFavorite(meal);

    if (exists) {
      _favoriteMeals.removeWhere((m) => m.idMeal == meal.idMeal);
    } else {
      _favoriteMeals.add(meal);
    }

    notifyListeners();
  }
}