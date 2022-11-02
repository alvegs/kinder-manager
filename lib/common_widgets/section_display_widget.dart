import 'package:flutter/material.dart';

import '../model/section.dart';
import 'custom_button.dart';

/// Custom widget to display a section in home page.
class SectionDisplay extends StatelessWidget {
  final Section section;
  final VoidCallback onPressed;
  /// title : name of the section.
  /// onPressed : function to be executed when button is pressed
  const SectionDisplay({Key? key, required this.section, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Image here!"),
          const SizedBox(
            height: 10,
          ),
          CustomRaisedButton(
            onPressed: onPressed,
            height: 32,
            backgroundColor: Colors.green[200],
            child: Text(section.name),
          ),
        ],
      ),
    );
  }
}
