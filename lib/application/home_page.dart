import 'package:flutter/material.dart';
import 'package:kindermanager/common_widgets/section_display.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Sections"),
      ),

      /// Centers the content of the page.
      body: Center(
        /// Displays the content in gridview.
        child: GridView.count(
          /// Gridview specifications.
          shrinkWrap: true,
          primary: false,
          padding: const EdgeInsets.all(50),
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          crossAxisCount: 2,
          children: const <Widget>[
            /// todo should update to read from dummy data.
            /// Custom Section widget is used to display sections.
            SectionDisplay(title: "Red", color: Colors.redAccent),
            SectionDisplay(title: "Grey", color: Colors.black12),
            SectionDisplay(title: "Pink", color: Colors.pinkAccent),
            SectionDisplay(title: "Blue", color: Colors.blue),
            SectionDisplay(title: "Indigo", color: Colors.indigoAccent),
            SectionDisplay(title: "Teal", color: Colors.teal),
          ],
        ),
      ),

      /// Bottom navigation bar with admin and logout options.
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        items: const <BottomNavigationBarItem>[
          /// Admin icon item
          BottomNavigationBarItem(
            /// todo find a better icon to admin access !
            icon: Icon(Icons.settings_applications_sharp),
            label: 'Admin',
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
