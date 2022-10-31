import 'package:flutter/material.dart';
import 'package:kindermanager/application/section_start_page.dart';
import 'package:kindermanager/common_widgets/section_display_widget.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';

/// Homepage will be displayed after login,
/// user will have options to select a section or
/// to logout.
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Keeps track of the selected bottom icon.
  int _selectedIndex = 0;

  /// Updates the selected index
  /// when clicked on the bottom icon.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /// Moves to Section start page.
  void _onSectionPressed(String title) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => SectionStartPage(title: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Sections"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: GestureDetector(
              onTap: () {
                // todo make simple account info page.
              },
              child: const Icon(
                Icons.account_box_rounded,
                size: 35.0,
              ),
            ),
          ),
        ],
      ),

      /// Centers the content of the page.
      body: Padding(
        padding: const EdgeInsets.only(top: 50, right: 15, left: 15),
        child: GridView.count(
          /// Gridview specifications.
          shrinkWrap: true,
          crossAxisCount: 2,
          children: <Widget>[
            /// Custom Section widget is used to display sections.
            SectionDisplay(
                title: "Section 1",
                onPressed: () => _onSectionPressed("Section 1")),
            SectionDisplay(
                title: "Section 2",
                onPressed: () => _onSectionPressed("Section 2")),
            SectionDisplay(
                title: "Section 3",
                onPressed: () => _onSectionPressed("Section 3")),
            SectionDisplay(
                title: "Section 4",
                onPressed: () => _onSectionPressed("Section 4")),
            SectionDisplay(
                title: "Section 5",
                onPressed: () => _onSectionPressed("Section 5")),
            SectionDisplay(
                title: "Section 6",
                onPressed: () => _onSectionPressed("Section 6")),
          ],
        ),
      ),

      /// Bottom navigation bar with admin and logout options.
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        items: <BottomNavigationBarItem>[
          /// Admin icon item
          const BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'New section',
          ),

          /// Logout icon item
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                final auth = Provider.of<Auth>(
                  context,
                  listen: false,
                );
                /// todo display a dialog box before signing out the user.
                auth.signOut();
              },
              icon: const Icon(Icons.settings_applications_sharp),
            ),
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
