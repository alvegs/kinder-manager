import 'package:flutter/material.dart';
import 'package:kindermanager/application/section_start_page.dart';
import 'package:kindermanager/common_widgets/section_display_widget.dart';
import 'package:kindermanager/services/firebase_database.dart';
import 'package:provider/provider.dart';

import '../model/section.dart';
import '../services/auth.dart';

/// Homepage will be displayed after successful login,
/// user will have options to select a section, create a new section
/// or to logout.
class SectionsPage extends StatefulWidget {
  const SectionsPage({Key? key}) : super(key: key);

  @override
  State<SectionsPage> createState() => _SectionsPageState();
}

class _SectionsPageState extends State<SectionsPage> {
  /// Key to validate the form.
  final formKey = GlobalKey<FormState>();

  /// Initial value of section name.
  String sectionName = " ";

  /// Keeps track of the selected bottom icon.
  int _selectedIndex = 0;

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
              return GridView.builder(
                padding: const EdgeInsets.only(
                  top: 40,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,

                ),
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return SectionDisplay(
                    imageUrl: "assets/images/kindergarten.webp",
                    section: snapshot.data![index],
                    onPressed: () {
                      _onSectionPressed(snapshot.data![index]);
                    },
                  );
                },
              );
            }
            return const Center(child: Text("Sections is empty!"));
          }),

      /// Bottom navigation bar with add new section and logout options.
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        items: <BottomNavigationBarItem>[
          /// Adding a new section icon to bottom navigation bar.
          BottomNavigationBarItem(
            icon: IconButton(
                onPressed: () {
                  final database =
                      Provider.of<FirebaseDatabase>(context, listen: false);

                  /// Creating a bottom model sheet to add a new section
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 200,
                        color: Colors.lime,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text('Add new section'),
                              const SizedBox(
                                height: 20,
                              ),
                              createForm(),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                  child: const Text('Add section'),
                                  onPressed: () {
                                    _onSave(database);
                                  }),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.add_box)),
            label: 'New section',
          ),

          /// Adding Logout icon item to bottom navigation bar
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

  /// Creating a form to display in bottom sheet model
  Widget createForm() {
    return Form(
      key: formKey,
      child: Column(children: [
        TextFormField(
          decoration: const InputDecoration(labelText: "Section name"),
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter a valid section name";
            }
            return null;
          },
          onSaved: (value) => sectionName = value!,
        ),
      ]),
    );
  }

  /// Validating the form
  bool _validateAndSaveForm() {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  /// Updates the selected index
  /// when clicked on the bottom icon.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /// Validating and saving new section to the firestore.
  Future<void> _onSave(FirebaseDatabase database) async {
    if (_validateAndSaveForm()) {
      final section = Section(name: sectionName, id: '');
      await database.createSection(section);
      Navigator.pop(context);
    }
  }

  /// Moves to selected Section start page.
  void _onSectionPressed(Section section) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => SectionStartPage(section: section),
      ),
    );
  }
}
