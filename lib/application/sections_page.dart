import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kindermanager/application/form_validator.dart';
import 'package:kindermanager/application/section_start_page.dart';

import 'package:kindermanager/custom_widgets/bottom_model_content_widget.dart';
import 'package:kindermanager/custom_widgets/custom_bottom_navigation_bar.dart';

import 'package:kindermanager/custom_widgets/section_display_widget.dart';
import 'package:kindermanager/custom_widgets/show_alert_dialog.dart';
import 'package:kindermanager/services/firebase_database.dart';
import 'package:provider/provider.dart';

import '../model/section.dart';
import '../services/auth.dart';

/// Homepage will be displayed after successful login,
/// user will have options to select a section, create a new section,
/// edit a section, delete a section or to logout.
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

  /// Default image to display.
  String imageUrl =
      "https://firebasestorage.googleapis.com/v0/b/kinder-manager.appspot.com/o/images%2Fjames%20webb%201.sep.jpeg?alt=media&token=e3c495af-e2a0-4165-ab46-2154014c6ad6";

  bool newImageSelected = false;

  /// Content of the page.
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<FirebaseDatabase>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],

      /// Appbar with title and logout icon.
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
            /// Displays a progress indicator if data is delayed
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
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
                  /// Custom SectionDisplay widget to display sections.
                  return SectionDisplay(
                    section: snapshot.data![index],
                    onPressed: () {
                      _onSectionPressed(snapshot.data![index]);
                    },
                    onLongPressed: () => _sectionEdit(snapshot.data![index].id,
                        snapshot.data![index].imageFile, database),
                  );
                },
              );
            }
            return const Center(child: Text("Sections is empty!"));
          }),

      /// Bottom navigation bar with add new section and logout options.
      bottomNavigationBar: CustomBottomNavigationBar(
        createForm: createForm(),
        onAddImage: pickImage,
        onAddSection: _onAddSection,
        onItemTapped: _onItemTapped,
        onLogOut: () async {
          final auth = Provider.of<Auth>(
            context,
            listen: false,
          );
          final result = await ShowAlertDialog(
            context,
            title: "Sign out",
            content: "Are you sure ?",
            leftButtonText: "Cancel",
            rightButtonText: "Logout",
          );
          result ? auth.signOut() : null;
        },
        selectedIndex: _selectedIndex,
      ),
    );
  }

  /// Updates the selected index
  /// when clicked on the bottom icon.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /// Moves to selected Section start page.
  void _onSectionPressed(Section section) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => SectionStartPage(section: section),
      ),
    );
  }

  /// Validating and saving new section to the firestore.
  Future<void> _onAddSection() async {
    if (_validateAndSaveForm()) {
      final database = Provider.of<FirebaseDatabase>(context, listen: false);
      final uniqueImageName = DateTime.now().millisecondsSinceEpoch.toString();
      final ref = fireStore.child("images").child(uniqueImageName);
      //todo null still image verdi !
      if (image == null) {
        ShowAlertDialog(context,
            title: "Error",
            content: "Please choose a image for your section !",
            leftButtonText: "",
            rightButtonText: "Ok");
      } else {
        await ref.putFile(image!);
        imageUrl = await ref.getDownloadURL();
        final section = Section(imageFile: imageUrl, name: sectionName, id: '');
        await database.createSection(section);
        Navigator.of(context).pop();
      }
    }
  }

  /// Edits a existing section and updates the new values
  void _sectionEdit(String docId, String imageUrl, FirebaseDatabase database) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        /// Moves bottom sheet along with the keyboard.
        final mediaQueryData = MediaQuery.of(context);

        /// Using custom widget to build bottom sheet.
        return BottomModelContent(
          mediaQueryData: mediaQueryData,
          titleText: "Manage section",
          createForm: createForm(),
          onChangeImage: () {
            newImageSelected = true;
            pickImage();
          },
          onDeleteSection: () {
            _onDelete(database, docId);
          },
          onSaveSection: () {
            _onEditUpload(database, docId, imageUrl);
          },
        );
      },
    );
  }

  /// Validating and editing a existing section.
  Future<void> _onEditUpload(
      FirebaseDatabase database, String docId, String imageUrl) async {
    if (_validateAndSaveForm()) {
      if (newImageSelected == true) {
        final uniqueImageName =
            DateTime.now().millisecondsSinceEpoch.toString();
        final ref = fireStore.child("images").child(uniqueImageName);
        await ref.putFile(image!);
        // todo check for null and display alert dialog box
        imageUrl = await ref.getDownloadURL();
        newImageSelected = !newImageSelected;
      }
      final section =
          Section(name: sectionName, id: docId, imageFile: imageUrl);
      await database.editSection(section);
      Navigator.pop(context);
    }
  }

  /// Deletes the selected section.
  Future<void> _onDelete(FirebaseDatabase database, String docId) async {
    final result =  await ShowAlertDialog(context,
        title: "Delete section",
        content: "You are going to delete a section. Are you sure ?",
        leftButtonText: "Cancel",
        rightButtonText: "Delete");
    if(result){
      final section = Section(name: sectionName, id: docId, imageFile: imageUrl);
      await database.deleteSection(section);
    }
    Navigator.pop(context);
  }

  /// Creating a form to display in bottom sheet model
  Widget createForm() {
    return Form(
      key: formKey,
      child: Column(children: [
        TextFormField(
          decoration: const InputDecoration(labelText: " New section name"),
          validator: (value) {
            if (!FormValidator.isNameValid(value)) {
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

  /// Picks image from the gallery.
  Future<void> pickImage() async {
    try {
      final image = await imagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 5);
      if (image == null) return;
      setState(() {
        this.image = File(image.path);
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
//todo remove last selected image from gallery to avoid duplicate images.
}
