import 'package:flutter/material.dart';

import '../design_theme.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar(
      {Key? key,
      required this.onAddImage,
      required this.onAddSection,
      required this.onItemTapped,
      required this.selectedIndex,
      required this.createForm,
      required this.onLogOut})
      : super(key: key);
  final VoidCallback onAddImage;
  final VoidCallback onLogOut;
  final VoidCallback onAddSection;
  final void Function(int index) onItemTapped;
  final int selectedIndex;
  final Widget createForm;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.lightGreen[100],
      elevation: 50,
      items: <BottomNavigationBarItem>[
        /// Adding a new section icon to bottom navigation bar.
        BottomNavigationBarItem(
          icon: IconButton(
            iconSize: 25,
            onPressed: createBottomSheet,
            icon: const Icon(Icons.add_box),
          ),
          label: 'New section',
        ),

        /// Adding Logout icon item to bottom navigation bar
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: widget.onLogOut,
            icon: const Icon(Icons.settings_applications_sharp),
          ),
          label: 'Logout',
        ),
      ],
      currentIndex: widget.selectedIndex,
      selectedItemColor: Colors.lightGreen,
      onTap: widget.onItemTapped,
      selectedFontSize: fontSizeSmaller,
      iconSize: 24,
    );
  }

  /// Creating a bottom model sheet to add a new section
  void createBottomSheet() {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        /// Moves bottom sheet along with the keyboard.
        final mediaQueryData = MediaQuery.of(context);
        return Padding(
          padding: mediaQueryData.viewInsets,
          child: Container(
            height: 200,
            color: Colors.lightGreen[100],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('Add new section',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: fontSizeMedium)),
                  const SizedBox(
                    height: heightMedium,
                  ),
                  widget.createForm,
                  const SizedBox(
                    height: heightMedium,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: widget.onAddImage,
                          child: const Text('Add image')),
                      const SizedBox(
                        width: widthMedium,
                      ),
                      ElevatedButton(
                          onPressed: widget.onAddSection,
                          child: const Text('Save')),
                      const SizedBox(
                        height: heightMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
