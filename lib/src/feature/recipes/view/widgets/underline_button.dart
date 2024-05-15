// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:recipes_finder/src/res/colors.dart';

class UnderlineButton extends StatelessWidget {
  final String title;
  final bool isEnable;
  const UnderlineButton({
    Key? key,
    required this.title,
    required this.isEnable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isEnable ? primaryColor : backgroundColor,
            width: 2.0,
          ),
        ),
      ),
      child: TextButton(
        onPressed: () {},
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
