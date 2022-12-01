import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Custom alert dialog.
/// Returns the value chosen.
Future ShowAlertDialog(
  BuildContext context, {
  required String title,
  required String content,
  required String leftButtonText,
  required String rightButtonText,
}) {
  if(Platform.isIOS ){
    /// Displays IOS alert box
    return showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            CupertinoDialogAction(
              child: Text(leftButtonText),
              isDefaultAction: true,
              onPressed: () => Navigator.of(context).pop(false),
            ),
            CupertinoDialogAction(
              child: Text(rightButtonText),
              isDestructiveAction: true,
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        ),
    );
  }else{
    /// Displays default alert box
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
                child: Text(rightButtonText, style: TextStyle(color: Colors.red)),
              ),
            ],
          )
        ],
      ),
    );

  }



}
