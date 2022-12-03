import 'package:flutter/material.dart';

import '../custom_widgets/show_alert_dialog.dart';
import '../model/child.dart';
import '../services/firebase_database.dart';

class ShowCountPage extends StatelessWidget {
  const ShowCountPage({
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
    /// Used to control when back button is used.
    return WillPopScope(
      onWillPop: () async {
        final result = await ShowAlertDialog(context,
          title: "Leaving count",
          content: "You are leaving count page ? ",
          leftButtonText: "Stay",
          rightButtonText: "Leave",
          isDestructive: true,);
        if(result){
          database.resetCount(sectionId);
          return true;
        }
       return false;
      },
      child: Scaffold(
        backgroundColor: Colors.lightGreen[50],
        appBar: AppBar(title: Text("Counting")),
        body: StreamBuilder<List<Child>>(
            stream: database.getSortedChildren(sectionId, status),
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
                      InkWell(
                        onTap: () async {
                          final child = Child(
                              name: snapshot.data![index].name,
                              id: snapshot.data![index].id,
                              imageFile: snapshot.data![index].imageFile,
                              status: snapshot.data![index].status,
                              isCounted: !snapshot.data![index].isCounted);
                          database.editChildWithId(sectionId, child);
                          if (await database.getCounted(sectionId) == 0) {
                            final result = await ShowAlertDialog(context,
                                title: "Count success",
                                content: "Successfully counted ${snapshot.data
                                    ?.length} children",
                                leftButtonText: "Recount",
                                rightButtonText: "Ok",
                                isDestructive: false);
                            if (result) {
                              database.resetCount(sectionId);
                              Navigator.pop(context);
                            } else {
                              database.resetCount(sectionId);
                            }
                          }
                        },
                        child: ClipRRect(
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
              return Center(child: Image.asset("assets/images/empty.png"));
            }),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.repeat),
            onPressed: () {
              database.resetCount(sectionId);
            }
        ),
      ),
    );
  }
}
