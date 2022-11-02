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
}
