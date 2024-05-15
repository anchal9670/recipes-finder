import 'package:flutter/material.dart';
import 'package:recipes_finder/src/res/colors.dart';

class BottomFixedButton extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback onTab;
  const BottomFixedButton(
      {Key? key, required this.title, this.subtitle, required this.onTab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTab,
        child: Container(
          height: 65,
          color: darkBackgroundColor,
          child: Align(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                  text: title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: primaryColor,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: subtitle,
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.red,
                        ))
                  ]),
            ),
          ),
        ));
  }
}
