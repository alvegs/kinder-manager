import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kindermanager/common_widgets/showDialog.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(widget.section.id);
    }
    final database = Provider.of<FirebaseDatabase>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("children"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: GestureDetector(
              onTap: () {
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
                              height: 20,
                            ),
                            createForm(),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                child: const Text('Add child'),
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
              child: const Icon(
                Icons.add_box,
                size: 35.0,
              ),
            ),
          ),
        ],
      ),

      /// Builds the content of the children page.
      body: StreamBuilder<List<Child>>(
          stream: database.getChildren(widget.section.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                padding: const EdgeInsets.only(top: 50),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          if (snapshot.data![index].status == "ARRIVED") {
                            status = await showAlertDialog(
                              context,
                              title: "Status",
                              content: "Choose the status of the child",
                              arriveEnabled: false,
                              absentEnabled: true,
                              pickedEnabled: true,
                            );
                          } else if (snapshot.data![index].status == "PICKED") {
                            status = await showAlertDialog(
                              context,
                              title: "Status",
                              content: "Choose the status of the child",
                              arriveEnabled: true,
                              absentEnabled: true,
                              pickedEnabled: false,
                            );
                          } else if (snapshot.data![index].status == "ABSENT") {
                            status = await showAlertDialog(
                              context,
                              title: "Status",
                              content: "Choose the status of the child",
                              arriveEnabled: true,
                              absentEnabled: false,
                              pickedEnabled: true,
                            );
                          } else {
                            status = await showAlertDialog(
                              context,
                              title: "Status",
                              content: "Choose the status of the child",
                              arriveEnabled: true,
                              absentEnabled: true,
                              pickedEnabled: true,
                            );
                          }

                          final updateStatus = Child(
                              name: snapshot.data![index].name,
                              id: snapshot.data![index].id,
                              status: status);
                          database.editChild(widget.section, updateStatus);
                        },
                        onLongPress: () => _editChild(
                          widget.section,
                          snapshot.data![index].id,
                          snapshot.data![index].status,
                          database,
                        ),
                        child: Image.asset(
                          "assets/images/cartoon.jpeg",
                          height: 75,
                          width: 75,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        snapshot.data![index].name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  );
                },
              );
            }
            return const Center(child: Text("No child in this section!"));
          }),
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

  /// Validating and saving new section to the firestore.
  Future<void> _onSave(FirebaseDatabase database) async {
    if (_validateAndSaveForm()) {
      final child = Child(name: childName, id: "");
      await database.createChild(child, widget.section.id);
      Navigator.pop(context);
    }
  }

  void _editChild(Section section, String childDocId, String childStatus,
      FirebaseDatabase database) {
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
                        child: const Text('Delete'), onPressed: () {}),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        child: const Text('Edit'),
                        onPressed: () {
                          _onEdit(section, childDocId, childStatus, database);
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

  /// Validating and editing a existing section.
  Future<void> _onEdit(
    Section section,
    String childDocId,
    String childStatus,
    FirebaseDatabase database,
  ) async {
    if (_validateAndSaveForm()) {
      final child = Child(id: childDocId, name: childName, status: childStatus);
      await database.editChild(section, child);
      Navigator.pop(context);
    }
  }
}
