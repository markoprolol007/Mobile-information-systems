import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal.dart';

class ApiService {
  static const base = 'https://www.themealdb.com/api/json/v1/1';

  static Future<List<CategoryModel>> fetchCategories() async {
    final res = await http.get(Uri.parse('$base/categories.php'));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List list = data['categories'] ?? [];
      return list.map((e) => CategoryModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  static Future<List<Meal>> fetchMealsByCategory(String category) async {
    final res = await http.get(Uri.parse('$base/filter.php?c=$category'));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List list = data['meals'] ?? [];
      // note: filter returns idMeal, strMeal, strMealThumb only.
      return list
          .map((e) => Meal(
        idMeal: e['idMeal'] ?? '',
        strMeal: e['strMeal'] ?? '',
        strMealThumb: e['strMealThumb'] ?? '',
        ingredients: {},
      ))
          .toList();
    } else {
      throw Exception('Failed to load meals for category');
    }
  }

  static Future<List<Meal>> searchMeals(String query) async {
    final res = await http.get(Uri.parse('$base/search.php?s=$query'));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List? list = data['meals'];
      if (list == null) return [];
      return list.map((e) => Meal.fromJson(e)).toList();
    } else {
      throw Exception('Failed to search meals');
    }
  }

  static Future<Meal> fetchMealDetail(String id) async {
    final res = await http.get(Uri.parse('$base/lookup.php?i=$id'));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List list = data['meals'] ?? [];
      if (list.isEmpty) throw Exception('Meal not found');
      return Meal.fromJson(list[0]);
    } else {
      throw Exception('Failed to fetch meal detail');
    }
  }

  static Future<Meal> fetchRandomMeal() async {
    final res = await http.get(Uri.parse('$base/random.php'));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List list = data['meals'] ?? [];
      return Meal.fromJson(list[0]);
    } else {
      throw Exception('Failed to fetch random meal');
    }
  }
}