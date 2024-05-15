import 'dart:convert';

import 'package:recipes_finder/src/feature/recipes/repository/recipes_repo.dart';
import 'package:recipes_finder/src/modals/recipe_model.dart';

import 'package:riverpod/riverpod.dart';

final recipesProvider =
    StateNotifierProvider<RecipesNotifier, List<RecipesModel>>(
  (ref) => RecipesNotifier(),
);

class RecipesNotifier extends StateNotifier<List<RecipesModel>> {
  RecipesNotifier() : super([]);

  void saved(List<RecipesModel> newRecipes) {
    for (var newRecipe in newRecipes) {
      if (isExist(newRecipe)) {
        state = state.where((store) => store != newRecipe).toList();
      } else {
        state = [...state, newRecipe];
      }
    }
  }

  bool isExist(RecipesModel recipes) {
    return state.contains(recipes);
  }
}

class RecipesController {
  final recipesRepo = RecipesRepository();

  Future<List<RecipesModel>> getRecipes() async {
    try {
      // Fetch recipes
      final response = await recipesRepo.fetchRecipesInformationBulk();
      final data = jsonDecode(response.body);
      // List to store RecipesModel instances
      List<RecipesModel> recipes = [];
      final jsons = data["recipes"];
      // Iterate through the data and create RecipesModel instances
      for (dynamic i in jsons) {
        recipes.add(RecipesModel.fromJson(i));
      }
      return recipes;
    } catch (e) {
      // Handle errors
      print("Error in controller $e");

      // Return an empty list in case of an error
      return [];
    }
  }
}

final recipesControllerProvider = Provider<RecipesController>((ref) {
  return RecipesController();
});

final allRecipesProvider = FutureProvider<List<RecipesModel>>((ref) async {
  final controller = ref.read(recipesControllerProvider);
  return await controller.getRecipes();
});
