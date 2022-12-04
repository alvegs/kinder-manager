import 'package:flutter/material.dart';
import 'package:kindermanager/design_theme.dart';

//import 'package:image_picker/image_picker.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onLongPress: onLongPressed,
          onTap: onPressed,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              section.imageFile,
              height: 110,
              width: 110,
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(
          height: heightSmall,
        ),
        Text(section.name,
            style: const TextStyle(
              fontSize: fontSizeMedium,
              fontWeight: FontWeight.w600,
            )),
      ],
    );
  }
}
