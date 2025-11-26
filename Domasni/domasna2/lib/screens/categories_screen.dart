import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/category.dart';
import '../widgets/category_card.dart';
import 'meals_by_category_screen.dart';
import 'meal_detail_screen.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late Future<List<CategoryModel>> _future;
  List<CategoryModel> _all = [];
  List<CategoryModel> _filtered = [];

  @override
  void initState() {
    super.initState();
    _future = ApiService.fetchCategories();
    _future.then((value) {
      setState(() {
        _all = value;
        _filtered = value;
      });
    });
  }

  void _search(String q) {
    setState(() {
      _filtered = _all
          .where((c) => c.strCategory.toLowerCase().contains(q.toLowerCase()))
          .toList();
    });
  }

  void _openRandom() async {
    try {
      final meal = await ApiService.fetchRandomMeal();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => MealDetailScreen(mealId: meal.idMeal)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Грешка')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Категории'),
        actions: [
          IconButton(onPressed: _openRandom, icon: Icon(Icons.casino)),
        ],
      ),
      body: FutureBuilder<List<CategoryModel>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Грешка при вчитување'));
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Пребарај категории...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: _search,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: _filtered.length,
                  itemBuilder: (ctx, i) {
                    final cat = _filtered[i];
                    return CategoryCard(
                      category: cat,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => MealsByCategoryScreen(category: cat.strCategory)));
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}