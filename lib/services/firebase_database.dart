import 'package:cloud_firestore/cloud_firestore.dart';

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
                  id: data[snapshot.id],
                  name: data["name"],
                );
              },
            ).toList());
  }

  /// Creates a new section.
  /// section : section to be added.
  Future<void> createSection(Section section) async {
    final String uniqueDocId = DateTime.now().toIso8601String();
    _setData(data: section.toMap(), path: "sections/$uniqueDocId/");
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
    final String uniqueDocId = DateTime.now().toIso8601String();
    _setData(
        data: child.toMap(), path: "sections/$docId/children/$uniqueDocId ");
  }
}
