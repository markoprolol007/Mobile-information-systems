import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/meal.dart';
import '../widgets/meal_card.dart';
import 'meal_detail_screen.dart';
import 'package:provider/provider.dart';
import '../services/meal_service.dart';

class MealsByCategoryScreen extends StatefulWidget {
  static const routeName = '/meals-by-category';
  final String? category;

  MealsByCategoryScreen({Key? key, this.category}) : super(key: key);

  @override
  _MealsByCategoryScreenState createState() => _MealsByCategoryScreenState();
}

class _MealsByCategoryScreenState extends State<MealsByCategoryScreen> {
  late Future<List<Meal>> _future;
  List<Meal> _all = [];
  List<Meal> _filtered = [];
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _future = ApiService.fetchMealsByCategory(widget.category ?? '');
    _future.then((value) {
      setState(() {
        _all = value;
        _filtered = value;
      });
    });
  }

  void _search(String q) async {
    if (q.trim().isEmpty) {
      setState(() => _filtered = _all);
      return;
    }
    try {
      final results = await ApiService.searchMeals(q);
      // filter results by category if possible
      setState(() => _filtered = results.where((m) => m.idMeal.isNotEmpty).toList());
    } catch (e) {
      // ignore
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.category ?? 'Јадења';
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: FutureBuilder<List<Meal>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) return Center(child: Text('Грешка'));

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchCtrl,
                  decoration: InputDecoration(
                    hintText: 'Пребарај јадења...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: _search,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: _filtered.length,
                  itemBuilder: (ctx, i) {
                    final meal = _filtered[i];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Image.network(
                                meal.strMealThumb,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              meal.strMeal,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                            const SizedBox(height: 6),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Детали копче
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => MealDetailScreen(mealId: meal.idMeal),
                                    ));
                                  },
                                  child: Text('Детали'),
                                ),
                                Consumer<MealService>(
                                  builder: (context, mealService, _) {
                                    final isFav = mealService.isFavorite(meal);
                                    return IconButton(
                                      icon: Icon(
                                        isFav ? Icons.favorite : Icons.favorite_border,
                                        color: isFav ? Colors.red : Colors.grey,
                                      ),
                                      onPressed: () {
                                        mealService.toggleFavorite(meal);
                                        setState(() {});
                                      },
                                    );
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}