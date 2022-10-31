import 'package:flutter/material.dart';

import 'custom_raised_button.dart';

/// Custom widget to display a section in home page.
class SectionDisplay extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  /// title : name of the section.
  /// onPressed : function to be executed when button is pressed
  const SectionDisplay({Key? key, required this.title, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: Text(title),
        ),
      ],
    );
  }
}
