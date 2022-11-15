import 'package:flutter/material.dart';

/// Custom alert dialog.
/// Returns the value chosen.
Future ShowAlertDialog(
  BuildContext context, {
  required String title,
  required String content,
  required String leftButtonText,
  required String rightButtonText,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      actionsPadding: EdgeInsets.all(10),
      title: Text(title),
      content: Text(content),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(leftButtonText),
            ),
            SizedBox(width: 15),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(rightButtonText),
            ),
          ],
        )
      ],
    ),
  );
}
