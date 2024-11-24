import 'package:agrolyn/api/recipe_service.dart';
import 'package:flutter/material.dart';

class CommonRecipeNotifier extends ChangeNotifier {
  final BuildContext context;

  CommonRecipeNotifier({required this.context}) {
    fetchRecipe();
  }

  final RecipeService _recipeService = RecipeService();
  List recipes = [];

  void fetchRecipe() async {
    recipes = await _recipeService.getRecipes();
    notifyListeners();
  }
}
