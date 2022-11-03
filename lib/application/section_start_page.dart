import 'package:flutter/material.dart';
import 'package:kindermanager/application/children_page.dart';
import 'package:kindermanager/services/firebase_database.dart';
import 'package:provider/provider.dart';

import '../common_widgets/custom_button.dart';
import '../model/section.dart';

/// Displays a page with count and overview options.
class SectionStartPage extends StatefulWidget {
  final Section section;

  const SectionStartPage({Key? key, required this.section}) : super(key: key);

  @override
  State<SectionStartPage> createState() => _SectionStartPageState();
}

class _SectionStartPageState extends State<SectionStartPage> {
  /// Keeps track of the selected bottom icon.
  int _selectedIndex = 0;

  /// Updates the selected index
  /// when clicked on the bottom icon.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
          CustomRaisedButton(
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
          CustomRaisedButton(
            height: 100,
            backgroundColor: Colors.lightGreen[300],
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => Provider<FirebaseDatabase>(
                    create: (_) => FirebaseDatabase(),
                    child: ChildrenPage( section: widget.section,)),
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
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        items: const <BottomNavigationBarItem>[
          /// Home icon item
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),

          /// Logout icon item
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightGreen,
        onTap: _onItemTapped,
        selectedFontSize: 16,
        iconSize: 24,
      ),
    );
  }
}
