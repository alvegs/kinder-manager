import 'package:flutter/material.dart';

class SectionDisplay extends StatelessWidget {
  final String title;
  final Color color;

  const SectionDisplay({Key? key, required this.title, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(8),
        color: color,
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 36,
            ),
          ),
        ),
      ),
      onTap: () {
        print("Pressed section : " + this.title);
      },
    );
  }
}
