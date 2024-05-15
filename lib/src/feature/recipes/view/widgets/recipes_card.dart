// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:recipes_finder/src/res/colors.dart';

class RecipesCard extends StatelessWidget {
  final String image;
  final String title;
  final String preprationTime;
  final String rating;
  final bool isBookmarked;
  final VoidCallback onTab;
  const RecipesCard({
    Key? key,
    required this.image,
    required this.title,
    required this.preprationTime,
    required this.rating,
    required this.isBookmarked,
    required this.onTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(
            color: backgroundColor,
          ),
        ),
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 15),
                    child: Center(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: ClipOval(
                          child: Image.network(
                            image,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const Icon(
                        Icons.star_half_outlined,
                        color: AppColor.apptheme,
                      ),
                      Text(
                        rating,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppColor.apptheme,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 5, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 90,
                          margin: const EdgeInsets.only(left: 5),
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: onTab,
                          icon: isBookmarked
                              ? const Icon(Icons.bookmark, color: primaryColor)
                              : const Icon(
                                  Icons.bookmark_border_outlined,
                                  color: primaryColor,
                                ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5, left: 5),
                      child: Container(
                        width: double.infinity,
                        height: 17,
                        alignment: Alignment.center,
                        child: Text(
                          'Preparation Time: $preprationTime min',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
