import 'package:flutter/material.dart';

/// Custom alert dialog that shows the available status.
/// Returns the status chosen.
Future CustomDialogBox(
  BuildContext context, {
  required String title,
  required String content,

  /// Disables buttons that are not necessary
  bool arriveEnabled = true,
  bool pickedEnabled = true,
  bool absentEnabled = true,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      actionsPadding: EdgeInsets.all(10),
      title: Text(title),
      content: Text(content),
      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            arriveEnabled
                ? ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.lightGreen)),
                    onPressed: () => Navigator.of(context).pop("ARRIVED"),
                    child: Text("ARRIVED"),
                  )
                : Container(),
            pickedEnabled
                ? ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.brown)),
                    onPressed: () => Navigator.of(context).pop("PICKED"),
                    child: Text("PICKED"),
                  )
                : Container(),
            absentEnabled
                ? ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.redAccent)),
                    onPressed: () => Navigator.of(context).pop("ABSENT"),
                    child: Text("ABSENT"),
                  )
                : Container(),
            SizedBox(
              height: 10,
            ),
          ],
        )
      ],
    ),
  );
}
