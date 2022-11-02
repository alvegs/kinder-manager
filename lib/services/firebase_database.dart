import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/section.dart';

class FirebaseDatabase {
  final database = FirebaseFirestore.instance;

  Stream<List<Section>> getSections() {
    return database
        .collection("sections")
        .snapshots()
        .map((snapshot) => snapshot.docs.map(
              (snapshot) {
                final data = snapshot.data();
                return Section(
                  name: data["section name"],
                );
              },
            ).toList());
  }

  Future<void> createSection(Section section) async{
    final String uniqueDocId = DateTime.now().toIso8601String();
    _setData(data: section.toMap(), path: "sections/$uniqueDocId/");
  }

  Future<void> _setData(
      {required String path, required Map<String, dynamic> data}) async {
    final documentRef = FirebaseFirestore.instance.doc(path);
    await documentRef.set(data);
  }
}
