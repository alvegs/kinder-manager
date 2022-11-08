import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../model/section.dart';

/// Custom widget to display a section in home page.
class SectionDisplay extends StatelessWidget {
  final Section section;
  final VoidCallback onPressed;
  final VoidCallback onLongPressed;

  /// title : name of the section.
  /// onPressed : function to be executed when button is pressed
  const SectionDisplay({
    Key? key,
    required this.section,
    required this.onPressed,
    required this.onLongPressed,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
              onLongPress: onLongPressed,
              onTap: onPressed,
              child: Image.network(
                section.imageFile,
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
