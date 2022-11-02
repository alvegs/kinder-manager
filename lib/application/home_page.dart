import 'package:flutter/material.dart';
import 'package:kindermanager/application/section_start_page.dart';
import 'package:kindermanager/common_widgets/section_display_widget.dart';
import 'package:kindermanager/services/firebase_database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/section.dart';
import '../services/auth.dart';

/// Homepage will be displayed after successful login,
/// user will have options to select a section, create a new section
/// or to logout.
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
    final database = Provider.of<FirebaseDatabase>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey[100],

      /// Appbar with title and logout icon.
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

      /// Main the content of the page - sections.
      body: StreamBuilder<List<Section>>(
          stream: database.getSections(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SectionDisplay(
                      section: snapshot.data![index],
                      onPressed: () {
                        _onSectionPressed(snapshot.data![index].name);
                      },
                    );
                  },
                ),
              );
            }
            return const Center(child: Text("Sections is empty!"));
          }),

      /// Bottom navigation bar with admin and logout options.
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        items: <BottomNavigationBarItem>[
          /// Admin icon item
          BottomNavigationBarItem(
            icon: IconButton(onPressed: () {}, icon: const Icon(Icons.add_box)),
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
