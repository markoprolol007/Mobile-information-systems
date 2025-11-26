import 'package:flutter/material.dart';
import 'screens/categories_screen.dart';
import 'screens/meals_by_category_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'models/meal.dart';


void main() {
  runApp(RecipeApp());
}


class RecipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Рецепти',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: CategoriesScreen(),
      routes: {
        MealsByCategoryScreen.routeName: (_) => MealsByCategoryScreen(),
        MealDetailScreen.routeName: (_) => MealDetailScreen(),
      },
    );
  }
}