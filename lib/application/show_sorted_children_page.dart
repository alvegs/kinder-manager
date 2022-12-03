import 'package:flutter/material.dart';

import '../model/child.dart';
import '../services/firebase_database.dart';

/// Shows children according to the status chosen
class ShowSortedChildren extends StatefulWidget {
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
  State<ShowSortedChildren> createState() => _ShowSortedChildrenState();
}

class _ShowSortedChildrenState extends State<ShowSortedChildren> {
  @override
  Widget build(BuildContext context) {
    /// Sets appbar color according to the status.
    var backgroundColor = Colors.lightGreen;
    if (widget.status == "ARRIVED") {
      backgroundColor = Colors.lightGreen;
    } else if (widget.status == "PICKED") {
      backgroundColor = Colors.blue;
    } else if (widget.status == "ABSENT") {
      backgroundColor = Colors.red;
    }
    return Scaffold(
      /// Sets background color according to the status
      backgroundColor: backgroundColor.shade50,
      appBar:
          AppBar(title: Text(widget.status), backgroundColor: backgroundColor),
      body: StreamBuilder<List<Child>>(
        stream:
            widget.database.getSortedChildren(widget.sectionId, widget.status),
        builder: (context, snapshot) {
          if (snapshot.data != null && snapshot.data!.isNotEmpty) {
            return GridView.builder(
              padding: const EdgeInsets.only(top: 50),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      snapshot.data![index].imageFile,
                      height: 110,
                      width: 110,
                      fit: BoxFit.fill,
                      color: snapshot.data![index].isCounted
                          ? Colors.white.withOpacity(0.2)
                          : Colors.white.withOpacity(1),
                      colorBlendMode: BlendMode.modulate,
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
