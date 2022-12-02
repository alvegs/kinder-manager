import 'package:flutter/material.dart';

import '../model/child.dart';
import '../services/firebase_database.dart';

/// Shows children according to the status chosen
class ShowSortedChildren extends StatelessWidget {

  /// status   : status of the child
  /// docId    : id of the section, child belongs to
  /// database : instance of database
  const ShowSortedChildren({
    Key? key,
    required this.status,
    required this.sectionId,
    required this.database,
  }) : super(key: key);
  final String status;
  final String sectionId;
  final FirebaseDatabase database;

  @override
  Widget build(BuildContext context) {
    /// Sets appbar color according to the section.
    var backgroundColor = Colors.lightGreen;
    if (status == "ARRIVED") {
      backgroundColor = Colors.lightGreen;
    } else if (status == "PICKED") {
      backgroundColor = Colors.brown;
    } else if (status == "ABSENT") {
      backgroundColor = Colors.red;
    }
    return Scaffold(
      appBar: AppBar(title: Text(status), backgroundColor: backgroundColor),
      body: StreamBuilder<List<Child>>(
        stream: database.getSortedChildren(sectionId, status),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              padding: const EdgeInsets.only(top: 50),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(children: [
                  Image.network(
                    snapshot.data![index].imageFile,
                    height: 110,
                    width: 110,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    snapshot.data![index].name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ]);
              },
            );
          }
          return const Center(child: Text("No child in this section!"));
        },
      ),
    );
  }
}
