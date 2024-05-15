import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:recipes_finder/src/feature/recipes/controller/saved_recipes.dart';
import 'package:recipes_finder/src/feature/recipes/view/detailed_recipes.dart';
import 'package:recipes_finder/src/feature/recipes/view/saved_recipes_view.dart';
import 'package:recipes_finder/src/feature/recipes/view/widgets/custom_serach_bar.dart';
import 'package:recipes_finder/src/feature/recipes/view/widgets/recipes_card.dart';
import 'package:recipes_finder/src/res/colors.dart';

class RecipesView extends StatefulWidget {
  const RecipesView({Key? key}) : super(key: key);

  @override
  State<RecipesView> createState() => _RecipesViewState();
}

class _RecipesViewState extends State<RecipesView> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          " Recipes",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black54,
        ),
        leading: const Icon(
          Icons.fastfood_sharp,
          color: darkerBackgroundColor,
          size: 40,
        ),
        actions: [
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SavedRecipesView(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.bookmark,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
        backgroundColor: Colors.white60,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CustomSearchBar(
              hintText: 'Search Recipes',
              onChanged: (String value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final asyncValue = ref.watch(allRecipesProvider);
                final savedData = ref.watch(recipesProvider);
                return asyncValue.when(
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (error, stackTrace) => Center(
                    child: Text('Error: $error'),
                  ),
                  data: (products) {
                    // Filter recipes based on search query
                    final filteredRecipes = products
                        .where((recipe) => recipe.name
                            .toLowerCase()
                            .contains(_searchQuery.toLowerCase()))
                        .toList();

                    return filteredRecipes.isEmpty
                        ? Lottie.asset(
                            'assets/images/no_data_found.json', // Path to your Lottie animation JSON file
                            width: 200,
                            height: 200,
                          )
                        : GridView.builder(
                            itemCount: filteredRecipes.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 20,
                              mainAxisExtent: 220,
                            ),
                            itemBuilder: (context, index) {
                              final isBookmarked = ref
                                  .watch(recipesProvider.notifier)
                                  .isExist(filteredRecipes[index]);
                              return GestureDetector(
                                child: RecipesCard(
                                  image: filteredRecipes[index].image,
                                  title: filteredRecipes[index].name,
                                  preprationTime: filteredRecipes[index]
                                      .prepTimeMinutes
                                      .toString(),
                                  rating:
                                      filteredRecipes[index].rating.toString(),
                                  isBookmarked: isBookmarked,
                                  onTab: () {
                                    ref
                                        .read(recipesProvider.notifier)
                                        .saved([filteredRecipes[index]]);
                                  },
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => DetailedRecipesView(
                                        recipe: filteredRecipes[index],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
