import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/child.dart';
import '../model/section.dart';
import '../services/firebase_database.dart';

class ChildrenPage extends StatefulWidget {
  final Section section;
   const ChildrenPage({Key? key, required this.section}) : super(key: key);

  @override
  State<ChildrenPage> createState() => _ChildrenPageState();
}

class _ChildrenPageState extends State<ChildrenPage> {
  final formKey = GlobalKey<FormState>();


   String childName = " ";

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("children"),
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
      ],),
      body: Center(child: Text("Children page")),
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
       final child = Child(name: childName);
       //await database.createChild(child,"2022-11-02T23:12:59.091974");
       await database.createChild(child,widget.section.id);
       Navigator.pop(context);
     }
   }
}
