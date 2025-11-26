import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/api_service.dart';
import '../models/meal.dart';

class MealDetailScreen extends StatefulWidget {
  static const routeName = '/meal-detail';
  final String? mealId;

  MealDetailScreen({Key? key, this.mealId}) : super(key: key);

  @override
  _MealDetailScreenState createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  late Future<Meal> _future;

  @override
  void initState() {
    super.initState();
    _future = ApiService.fetchMealDetail(widget.mealId ?? '');
  }

  void _openYoutube(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Рецепт')),
      body: FutureBuilder<Meal>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) return Center(child: CircularProgressIndicator());
          if (snapshot.hasError) return Center(child: Text('Грешка при вчитување'));
          final meal = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(meal.strMealThumb),
                SizedBox(height: 12),
                Text(meal.strMeal, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                Text('Instructions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                SizedBox(height: 8),
                Text(meal.strInstructions ?? ''),
                SizedBox(height: 12),
                Text('Ingredients', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                SizedBox(height: 8),
                ...meal.ingredients.entries.map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Text('- \${e.key} : \${e.value}'),
                )),
                SizedBox(height: 12),
                if (meal.strYoutube != null && meal.strYoutube!.isNotEmpty)
                  ElevatedButton.icon(
                    onPressed: () => _openYoutube(meal.strYoutube!),
                    icon: Icon(Icons.play_circle_fill),
                    label: Text('YouTube'),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}