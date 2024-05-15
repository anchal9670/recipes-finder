import 'package:flutter/material.dart';
import 'package:recipes_finder/src/res/colors.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  const CustomSearchBar({
    Key? key,
    required this.hintText,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListTile(
        leading: const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Icon(
            Icons.search_rounded,
            size: 30,
            color: primaryColor,
          ),
        ),
        title: Container(
          margin: const EdgeInsets.only(bottom: 10),
          height: 40,
          width: MediaQuery.of(context).size.width,
          child: TextFormField(
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              filled: true,
              fillColor: const Color(0xFFEFFCE1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
              ),
              contentPadding: const EdgeInsets.all(0).copyWith(left: 10),
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 2, color: Color(0xFFD0F2AD)),
          borderRadius: BorderRadius.circular(12),
        ),
        tileColor: Colors.white,
      ),
    );
  }
}
