import 'package:flutter/material.dart';
import '../models/meal.dart';


class MealCard extends StatelessWidget {
  final Meal meal;
  final VoidCallback onTap;

  const MealCard({required this.meal, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 200,        // фиксна висина
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                meal.strMealThumb,
                fit: BoxFit.cover,
                height: 140,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              meal.strMeal,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}