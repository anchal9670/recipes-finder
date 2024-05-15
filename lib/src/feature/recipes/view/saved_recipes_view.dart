import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:recipes_finder/src/feature/recipes/controller/saved_recipes.dart';
import 'package:recipes_finder/src/feature/recipes/view/detailed_recipes.dart';
import 'package:recipes_finder/src/feature/recipes/view/widgets/recipes_card.dart';
import 'package:recipes_finder/src/res/colors.dart';

class SavedRecipesView extends StatefulWidget {
  const SavedRecipesView({Key? key}) : super(key: key);

  @override
  State<SavedRecipesView> createState() => _SavedRecipesViewState();
}

class _SavedRecipesViewState extends State<SavedRecipesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Saved Recipes",
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
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: primaryColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Consumer(
            builder: (context, ref, child) {
              final data = ref.watch(recipesProvider);
              return Expanded(
                child: data.isEmpty
                    ? Center(
                        child: Lottie.asset(
                          'assets/images/no_data_found.json', // Path to your Lottie animation JSON file
                          width: 200,
                          height: 200,
                        ),
                      )
                    : GridView.builder(
                        itemCount: data.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 20,
                          mainAxisExtent: 220,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          final isBookmarked = ref
                              .watch(recipesProvider.notifier)
                              .isExist(data[index]);
                          return GestureDetector(
                            child: RecipesCard(
                              image: data[index].image,
                              title: data[index].name,
                              preprationTime:
                                  data[index].prepTimeMinutes.toString(),
                              rating: data[index].rating.toString(),
                              isBookmarked: isBookmarked,
                              onTab: () {
                                ref
                                    .read(recipesProvider.notifier)
                                    .saved([data[index]]);
                              },
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DetailedRecipesView(
                                    recipe: data[index],
                                  ),
                                ),
                              );
                            },
                          );
                        }),
              );
            },
          ),
        ],
      ),
    );
  }
}
