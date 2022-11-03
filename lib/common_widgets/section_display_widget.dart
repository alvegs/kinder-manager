import 'package:flutter/material.dart';

import '../model/section.dart';
import 'custom_button.dart';

/// Custom widget to display a section in home page.
class SectionDisplay extends StatelessWidget {
  final Section section;
  final VoidCallback onPressed;
  final String imageUrl;

  /// title : name of the section.
  /// onPressed : function to be executed when button is pressed
  const SectionDisplay(
      {Key? key,
      required this.section,
      required this.onPressed,
      required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
              onTap: onPressed,
              child: Image.asset(
                imageUrl,
                height: 110,
                width: 110,
                fit: BoxFit.fill,
              )),
          const SizedBox(
            height: 5,
          ),
          Text(section.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              )),
        ],
      ),
    );
  }
}
