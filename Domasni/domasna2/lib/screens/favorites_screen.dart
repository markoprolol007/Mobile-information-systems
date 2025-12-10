import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/meal_service.dart';
import '../widgets/meal_card.dart';
import '../screens/meal_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<MealService>(context).favorites;

    return Scaffold(
      appBar: AppBar(title: Text("Омилени рецепти")),
      body: favorites.isEmpty
          ? Center(child: Text("Немате омилени рецепти."))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (ctx, i) => MealCard(
          meal: favorites[i],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MealDetailScreen(mealId: favorites[i].idMeal),
              ),
            );
          },
        ),
      ),
    );
  }
}