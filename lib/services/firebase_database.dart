import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../model/child.dart';
import '../model/section.dart';

/// Connects the project to firestore cloud and have functions to
/// Create, Read, Delete and Update project data.
class FirebaseDatabase {
  final database = FirebaseFirestore.instance;

  /// Returns a list of sections as streams
  Stream<List<Section>> getSections() {
    return database
        .collection("sections")
        .snapshots()
        .map((snapshot) => snapshot.docs.map(
              (snapshot) {
                final data = snapshot.data();
                return Section(
                  id: snapshot.id,
                  name: data["section name"],
                  imageFile: data["image file"],
                );
              },
            ).toList());
  }

  /// Returns a list of children as streams
  Stream<List<Child>> getChildren(String docId) {
    return database
        .collection("sections/$docId/children")
        .snapshots()
        .map((snapshot) => snapshot.docs.map(
              (snapshot) {
                final data = snapshot.data();
                return Child(
                  id: snapshot.id,
                  name: data["name"],
                  status: data["status"],
                );
              },
            ).toList());
  }

  /// Returns a list of children as streams sorted after status
  Stream<List<Child>> geSortedChildren(String docId, String status) {
    return database
        .collection("sections/$docId/children")
        .snapshots()
        .map((snapshot) => snapshot.docs.map(
          (snapshot) {
        final data = snapshot.data();
        return Child(
          id: snapshot.id,
          name: data["name"],
          status: data["status"],
        );
      },
    ).where((element) => element.status == status).toList());
  }

  /// Creates a new section.
  /// section : section to be added.
  Future<void> createSection(Section section) async {
    final String uniqueDocId = DateTime.now().toIso8601String();
    _setData(data: section.toMap(), path: "sections/$uniqueDocId/");
  }

  /// Edits a existing section.
  /// section : section to be edited.
  Future<void> editSection(Section section) async {
    _setData(data: section.toMap(), path: "sections/${section.id}/");
  }

  /// Edits a existing child.
  /// child : child to be edited.
  Future<void> editChild(Section section, Child child) async {
    _setData(
        data: child.toMap(),
        path: "sections/${section.id}/children/${child.id}/");
  }

  /// Adds given data to the firebase cloud.
  /// path : path where data should be added
  /// data : data to be added as map
  Future<void> _setData(
      {required String path, required Map<String, dynamic> data}) async {
    final documentRef = FirebaseFirestore.instance.doc(path);
    await documentRef.set(data);
  }

  /// Creates a new child inside a section.
  /// child : child to be added
  /// docId : id of the section
  Future<void> createChild(Child child, String docId) async {
    if (kDebugMode) {
      print(child.name);
    }
    final String uniqueDocId = DateTime.now().toIso8601String();
    _setData(
        data: child.toMap(), path: "sections/$docId/children/$uniqueDocId");
  }

  /// Deletes the given section.
  /// section : section to be deleted.
  Future<void> deleteSection(Section section) async {
    final documentRef =
        FirebaseFirestore.instance.doc("sections/${section.id}");
    await documentRef.delete();
  }

  /// Deletes the given section.
  /// section : section to be deleted.
  Future<void> deleteChild(Section section, Child child) async {
    final documentRef = FirebaseFirestore.instance
        .doc("sections/${section.id}/children/${child.id}");
    await documentRef.delete();
  }
}
