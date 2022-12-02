import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kindermanager/application/show_sorted_children_page.dart';

import 'package:kindermanager/custom_widgets/custom_dialog_box.dart';
import 'package:kindermanager/design_theme.dart';
import 'package:provider/provider.dart';

import '../custom_widgets/show_alert_dialog.dart';
import '../model/child.dart';
import '../model/section.dart';
import '../services/firebase_database.dart';

/// Displays children from the chosen Section and provides
/// functionalities for Creating, Reading, Updating and Deleting
/// a child.
class ChildrenPage extends StatefulWidget {
  final Section section;

  /// Creates an instance of Child
  /// section : section from which children will be displayed
  const ChildrenPage({
    Key? key,
    required this.section,
  }) : super(key: key);

  @override
  State<ChildrenPage> createState() => _ChildrenPageState();
}

class _ChildrenPageState extends State<ChildrenPage> {
  final formKey = GlobalKey<FormState>();
  String childName = " ";
  String status = " ";
  final imagePicker = ImagePicker();
  final fireStore = FirebaseStorage.instance.ref();
  String imageUrl = " ";
  File? image;
  bool newImageSelected = false;

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<FirebaseDatabase>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      appBar: AppBar(
        title: const Text("Children"),
        actions: [
          buildPopUpMenuContent(),
        ],
      ),

      /// Builds the content of the children page.
      body: StreamBuilder<List<Child>>(
          stream: database.getChildren(widget.section.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                padding: const EdgeInsets.only(top: 40),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          /// Displaying dialog box according to the status
                          if (snapshot.data![index].status == "ARRIVED") {
                            status = await CustomDialogBox(
                              context,
                              arriveEnabled: false,
                            );
                          } else if (snapshot.data![index].status == "PICKED") {
                            status = await CustomDialogBox(
                              context,
                              pickedEnabled: false,
                            );
                          } else if (snapshot.data![index].status == "ABSENT") {
                            status = await CustomDialogBox(
                              context,
                              absentEnabled: false,
                            );
                          } else {
                            status = await CustomDialogBox(
                              context,
                            );
                          }

                          /// Updating status of the child,
                          /// according to the chosen status.
                          final updateStatus = Child(
                              name: snapshot.data![index].name,
                              id: snapshot.data![index].id,
                              imageFile: snapshot.data![index].imageFile,
                              status: status);
                          database.editChild(widget.section, updateStatus);
                        },

                        /// Updating an existing child.
                        onLongPress: () => _editChild(
                          widget.section,
                          snapshot.data![index].id,
                          snapshot.data![index].status,
                          snapshot.data![index].imageFile,
                          database,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            snapshot.data![index].imageFile,
                            height: 110,
                            width: 110,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: heightSmall,
                      ),
                      Text(
                        snapshot.data![index].name,
                        style: const TextStyle(
                            fontSize: fontSizeMedium, fontWeight: fontWeightBold),
                      ),
                    ],
                  );
                },
              );
            } else {
              return const Center(child: Text("No child in this section!"));
            }
          }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 30, bottom: 10),
        child: FloatingActionButton(
          tooltip: "Add a child",
          backgroundColor: Colors.lightGreen,
          onPressed: () {
            final database =
                Provider.of<FirebaseDatabase>(context, listen: false);

            /// Creating a bottom model sheet to add a new section
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 200,
                  color: Colors.lightGreen[100],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text('Add new child'),
                        const SizedBox(
                          height: heightMedium,
                        ),
                        createForm(),
                        const SizedBox(
                          height: heightMedium,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: pickImage,
                              child: const Text("Add image"),
                            ),
                            SizedBox(width: 15),
                            ElevatedButton(
                                child: const Text('Add child'),
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
          child: Icon(Icons.add, size: 30),
        ),
      ),
    );
  }

  /// Creating a form to display in bottom sheet model
  Widget createForm() {
    return Form(
      key: formKey,
      child: Column(children: [
        TextFormField(
          decoration: const InputDecoration(labelText: "Child name"),
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter a valid child name";
            }
            return null;
          },
          onSaved: (value) => childName = value!,
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

  /// Validating and adding new child.
  Future<void> _onSave(FirebaseDatabase database) async {
    if (_validateAndSaveForm()) {
      final uniqueImageName = DateTime.now().millisecondsSinceEpoch.toString();
      final ref = fireStore.child("images").child(uniqueImageName);
      if (image == null) {
        bool result = await ShowAlertDialog(context,
            title: "Error",
            content: "Please choose a image for child !",
            rightButtonText: "Pick image",
            isDestructive: false);
        if (result) await pickImage();
      } else {
        await ref.putFile(image!);
        final imageUrl = await ref.getDownloadURL();
        final child = Child(name: childName, id: "", imageFile: imageUrl);
        await database.createChild(child, widget.section.id);
        image = null;
        Navigator.of(context).pop();
      }
    }
  }

  // todo Refactor
  void _editChild(Section section, String childId, String childStatus,
      String imageUrl, FirebaseDatabase database) {
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
                  'Manage child',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSizeMedium),
                ),
                const SizedBox(
                  height: heightMedium,
                ),

                /// Text field to enter the section name.
                createForm(),
                const SizedBox(
                  height: heightMedium,
                ),

                /// Aligning buttons side by side.
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                      ),
                      child: const Text('Delete',),
                      onPressed: () {
                        final child = Child(
                          id: childId,
                          name: childName,
                          imageFile: imageUrl,
                          status: status,
                        );
                        _onDelete(database, section, child);
                      },
                    ),
                    const SizedBox(
                      width: heightMedium,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        newImageSelected = true;
                        pickImage();
                      },
                      child: const Text("Image"),
                    ),
                    const SizedBox(
                      width: heightMedium,
                    ),
                    ElevatedButton(
                        child: const Text('Save'),
                        onPressed: () {
                          _onEdit(section, childId, childStatus, imageUrl,
                              database);
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

  /// Validating and updating an existing child.
  Future<void> _onEdit(
    Section section,
    String childId,
    String childStatus,
    String imageUrl,
    FirebaseDatabase database,
  ) async {
    if (_validateAndSaveForm()) {
      if (newImageSelected == true) {
        final uniqueImageName =
            DateTime.now().millisecondsSinceEpoch.toString();
        final ref = fireStore.child("images").child(uniqueImageName);
        if(image == null) return;
        await ref.putFile(image!);

        imageUrl = await ref.getDownloadURL();
        newImageSelected = !newImageSelected;
        image = null;
      }
      final child = Child(
          id: childId,
          name: childName,
          status: childStatus,
          imageFile: imageUrl);
      await database.editChild(section, child);
      Navigator.pop(context);
    }
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
      ShowAlertDialog(context,
          title: "Error",
          content: e.toString(),
          rightButtonText: "Ok",
          isDestructive: false);
    }
  }

  /// Deletes the selected section.
  Future<void> _onDelete(
      FirebaseDatabase database, Section section, Child child) async {
    final result = await ShowAlertDialog(context,
        title: "Delete section",
        content: "You are going to remove a child. Are you sure ?",
        leftButtonText: "Cancel",
        rightButtonText: "Delete",
        isDestructive: true);
    if (result) {
      //final child =
      //Child(name: childName, id: docId, imageFile: imageUrl);
      await database.deleteChild(section, child);
    }
    Navigator.pop(context);
  }

  Widget buildPopUpMenuContent() {
    final database = Provider.of<FirebaseDatabase>(context, listen: false);
    return PopupMenuButton(itemBuilder: (context) {
      return [
        PopupMenuItem<int>(
          value: 0,
          child: Text("ARRIVED"),
        ),
        PopupMenuItem<int>(
          value: 1,
          child: Text("PICKED"),
        ),
        PopupMenuItem<int>(
          value: 2,
          child: Text("ABSENT"),
        ),
      ];
    }, onSelected: (value) {
      if (value == 0) {
        Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (context) => ShowSortedChildren(
                  status: "ARRIVED",
                  sectionId: widget.section.id,
                  database: database,
                )));
      } else if (value == 1) {
        Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (context) => ShowSortedChildren(
                  status: "PICKED",
                  sectionId: widget.section.id,
                  database: database,
                )));
      } else if (value == 2) {
        Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (context) => ShowSortedChildren(
                  status: "ABSENT",
                  sectionId: widget.section.id,
                  database: database,
                )));
      }
    });
  }
}
