import 'package:flutter/material.dart';
import 'package:kindermanager/application/children_page.dart';
import 'package:kindermanager/services/firebase_database.dart';
import 'package:provider/provider.dart';

import '../custom_widgets/custom_button.dart';

import '../model/section.dart';

/// Displays a page with count and overview options.
class SectionStartPage extends StatefulWidget {
  final Section section;

  const SectionStartPage({Key? key, required this.section}) : super(key: key);

  @override
  State<SectionStartPage> createState() => _SectionStartPageState();
}

class _SectionStartPageState extends State<SectionStartPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.section.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// Vertical spacing
          const SizedBox(
            height: 90,
          ),

          /// Using custom button widget
          CustomButton(
            height: 100,
            backgroundColor: Colors.lightGreen[300],
            onPressed: () {},
            child: const Text(
              "Count",
              style: TextStyle(fontSize: 24),
            ),
          ),

          /// Vertical spacing
          const SizedBox(
            height: 10,
          ),

          /// Using custom button widget
          CustomButton(
            height: 100,
            backgroundColor: Colors.lightGreen[300],
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => Provider<FirebaseDatabase>(
                      create: (_) => FirebaseDatabase(),
                      child: ChildrenPage(
                        section: widget.section,
                      )),
                ),
              );
            },
            child: const Text(
              "Overview",
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),

      ///Bottom navigation bar with home and logout icons.

    );
  }
}
