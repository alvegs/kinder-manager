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
                  imageFile: data["image file"],
                );
              },
            ).toList());
  }

  /// Returns a list of children as stream
  /// sectionId : id of the section
  Stream<List<Child>> getChildren(String sectionId) {
    return database
        .collection("sections/$sectionId/children")
        .snapshots()
        .map((snapshot) => snapshot.docs.map(
              (snapshot) {
                final data = snapshot.data();
                return Child(
                  id: snapshot.id,
                  name: data["name"],
                  status: data["status"],
                  imageFile: data["image file"],
                );
              },
            ).toList());
  }

  /// Returns a list of children as stream sorted after status
  /// sectionId : id of the section
  /// status : status of the child
  Stream<List<Child>> getSortedChildren(String sectionId, String status) {
    return database
        .collection("sections/$sectionId/children")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (snapshot) {
                final data = snapshot.data();
                return Child(
                  id: snapshot.id,
                  name: data["name"],
                  status: data["status"],
                  imageFile: data["image file"],
                  isCounted: data["isCounted"],
                );
              },
            )
            /// Sorts according to the status
            .where((element) => element.status == status)
            .toList());
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

  Future<void> editChildWithId(String sectionId, Child child) async {
    _setData(
        data: child.toMap(), path: "sections/$sectionId/children/${child.id}/");
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
  /// sectionId : id of the section
  Future<void> createChild(Child child, String sectionId) async {
    final String uniqueDocId = DateTime.now().toIso8601String();
    _setData(
        data: child.toMap(), path: "sections/$sectionId/children/$uniqueDocId");
  }

  /// Deletes the given section.
  /// section : section to be deleted.
  Future<void> deleteSection(Section section) async {
    final documentRef =
        FirebaseFirestore.instance.doc("sections/${section.id}");
    await documentRef.delete();
  }

  /// Deletes the given child.
  /// section : section of the child
  /// child : child to be deleted
  Future<void> deleteChild(Section section, Child child) async {
    final documentRef = FirebaseFirestore.instance
        .doc("sections/${section.id}/children/${child.id}");
    await documentRef.delete();
  }

  /// Returns number of children with status set to ARRIVED,
  /// and isCounted is set to TRUE.
  /// sectionId : id of the section
  Future<int> getCounted(String sectionId) {
    return database
        .collection("sections/$sectionId/children")
        .where("status", isEqualTo: "ARRIVED")
        .where("isCounted", isEqualTo: false)
        .get()
        .then((QuerySnapshot querySnapshot) {
      return querySnapshot.size;
    });
  }

  /// Updates isCounted to false,
  /// when starting a new count.
  /// sectionId : id of the section
  void resetCount(String sectionId) {
    database
        .collection("sections/$sectionId/children")
        .where("status", isEqualTo: "ARRIVED")
        .where("isCounted", isEqualTo: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      /// iterates and updates isCounted field to false
      for (var doc in querySnapshot.docs) {
        doc.reference.update({
          'isCounted': false,
        });
      }
    });
  }
}
