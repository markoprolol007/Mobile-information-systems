class Meal {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;
  final String? strInstructions;
  final Map<String, String> ingredients; // ingredient -> measure
  final String? strYoutube;


  Meal({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
    this.strInstructions,
    required this.ingredients,
    this.strYoutube,
  });


  factory Meal.fromJson(Map<String, dynamic> json) {
// collect ingredients and measures
    final Map<String, String> ing = {};
    for (int i = 1; i <= 20; i++) {
      final ingKey = 'strIngredient\$i';
      final measKey = 'strMeasure\$i';
      final ingredient = json[ingKey];
      final measure = json[measKey];
      if (ingredient != null && ingredient.toString().trim().isNotEmpty) {
        ing[ingredient.toString()] = (measure ?? '').toString();
      }
    }


    return Meal(
      idMeal: json['idMeal'] ?? '',
      strMeal: json['strMeal'] ?? '',
      strMealThumb: json['strMealThumb'] ?? '',
      strInstructions: json['strInstructions'],
      ingredients: ing,
      strYoutube: json['strYoutube'],
    );
  }
}