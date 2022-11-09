import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
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

  final imagePicker = ImagePicker();
  final fireStore = FirebaseStorage.instance.ref();
  File? image;
  String imageUrl = "https://firebasestorage.googleapis.com/v0/b/kinder-manager.appspot.com/o/images%2Fjames%20webb%201.sep.jpeg?alt=media&token=e3c495af-e2a0-4165-ab46-2154014c6ad6";
  bool isLoading = false;


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
                    section: snapshot.data![index],
                    onPressed: () {
                      _onSectionPressed(snapshot.data![index]);
                    },
                    onLongPressed: () =>
                        _sectionEdit(snapshot.data![index].id, database),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      child: const Text('Add image'),
                                      onPressed: () {
                                        pickImage();
                                      }),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  isLoading
                                      ? const CircularProgressIndicator()
                                      : ElevatedButton(
                                          child: const Text('Add section'),
                                          onPressed: () {
                                            _onSave(database);
                                          }),
                                ],
                              ),
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
      final uniqueImageName = DateTime.now().millisecondsSinceEpoch.toString();
     final ref = fireStore.child("images").child(uniqueImageName);
          await ref.putFile(image!);
      // todo check for null and display alert dialog box
          imageUrl = await ref.getDownloadURL();
      final section = Section(imageFile: imageUrl, name: sectionName, id: '');
      await database.createSection(section);
      Navigator.pop(context);
    }
  }

  /// Validating and editing a existing section.
  Future<void> _onEdit(FirebaseDatabase database, String docId) async {
    if (_validateAndSaveForm()) {
      final section =
          Section(name: sectionName, id: docId, imageFile: imageUrl);
      await database.editSection(section);
      Navigator.pop(context);
    }
  }

  /// Deletes the selected section.
  Future<void> _onDelete(FirebaseDatabase database, String docId) async {
    final section = Section(name: sectionName, id: docId, imageFile: imageUrl);
    await database.deleteSection(section);
  }

  /// Moves to selected Section start page.
  void _onSectionPressed(Section section) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => SectionStartPage(section: section),
      ),
    );
  }

  /// Edits a existing section and updates the new values
  void _sectionEdit(String docId, FirebaseDatabase database) {
    /// Creating a bottom model sheet to edit a section
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
                const Text(
                  'Edit section',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),

                /// Text field to enter the section name.
                createForm(),
                const SizedBox(
                  height: 20,
                ),

                /// Aligning buttons side by side.
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        child: const Text('Delete '),
                        onPressed: () {
                          _onDelete(database, docId);
                        }),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        child: const Text('Edit '),
                        onPressed: () {
                          _onEdit(database, docId);
                        }),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  /// Picks image from the gallery.
  Future<void> pickImage() async {
    try {
         final image = await imagePicker.pickImage(
            source: ImageSource.gallery, imageQuality: 5);
      if (image == null) return;
      setState(() {
        isLoading = true;
              this.image = File(image.path);
      });
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
//todo remove last selected image from gallery to avoid duplicate images.
}
