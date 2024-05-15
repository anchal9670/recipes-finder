import 'package:flutter/material.dart';
import 'package:recipes_finder/src/modals/recipe_model.dart';
import 'package:recipes_finder/src/res/colors.dart';
import 'package:star_rating/star_rating.dart';

class DetailedRecipesView extends StatefulWidget {
  final RecipesModel recipe;
  const DetailedRecipesView({Key? key, required this.recipe}) : super(key: key);

  @override
  State<DetailedRecipesView> createState() => _DetailedRecipesViewState();
}

class _DetailedRecipesViewState extends State<DetailedRecipesView> {
  bool _showIngredients = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detailed Recipes",
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 250,
              child: Image.network(
                widget.recipe.image,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.recipe.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.people,
                        color: AppColor.apptheme,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.recipe.servings.toString(),
                        style: const TextStyle(
                            color: primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  StarRating(
                    mainAxisAlignment: MainAxisAlignment.center,
                    length: 5,
                    rating: widget.recipe.rating,
                    starSize: 10,
                    color: AppColor.apptheme,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '(${widget.recipe.reviewCount} Reviews)',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                'Meal Type : ${widget.recipe.mealType.join(', ')}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),

            // write logic for ingredirents and instrctions
            // Buttons to toggle between Ingredients and Instructions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _showIngredients = true;
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.42,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color:
                                _showIngredients ? primaryColor : Colors.black,
                            width: _showIngredients
                                ? 2.0
                                : 0.0, // Choose your desired border width here
                          ),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Ingredients',
                            style: TextStyle(
                              color: _showIngredients
                                  ? primaryColor
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _showIngredients = false;
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.42,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color:
                                !_showIngredients ? primaryColor : Colors.black,
                            width: !_showIngredients
                                ? 2.0
                                : 0.0, // Choose your desired border width here
                          ),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Instructions',
                            style: TextStyle(
                              color: !_showIngredients
                                  ? primaryColor
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Ingredients and Instructions Lists
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _showIngredients
                  ? widget.recipe.ingredients.length
                  : widget.recipe.instructions.length,
              itemBuilder: (context, index) {
                final item = _showIngredients
                    ? widget.recipe.ingredients[index]
                    : widget.recipe.instructions[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    title: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
