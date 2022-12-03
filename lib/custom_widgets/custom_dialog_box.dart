import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kindermanager/custom_widgets/custom_elevated_button.dart';
import 'package:kindermanager/design_theme.dart';

/// Custom alert dialog that shows the available status.
/// Returns the status chosen.
Future CustomDialogBox(
  BuildContext context, {

  /// Disables buttons that are not necessary
  bool arriveEnabled = true,
  bool pickedEnabled = true,
  bool absentEnabled = true,
}) {
  /// Dialog box when platform is IOS
  if (Platform.isIOS) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        insetAnimationCurve: Curves.easeInCirc,
        title: Text("Status"),
        content: Text("Choose the status of the child"),
        actions: [
          Column(
            children: [
              SizedBox(height: heightSmall),
              arriveEnabled
                  ? CustomElevatedButton(
                      status: "ARRIVED", color: Colors.lightGreen[400])
                  : Container(),
              SizedBox(height: heightSmall),
              pickedEnabled
                  ? CustomElevatedButton(
                      status: "PICKED", color: Colors.blueAccent[200])
                  : Container(),
              SizedBox(height: heightSmall),
              absentEnabled
                  ? CustomElevatedButton(
                      status: "ABSENT", color: Colors.redAccent[200])
                  : Container(),
              SizedBox(height: 15),
            ],
          )
        ],
      ),
    );
  }

  /// Dialog box to other platforms
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      actionsPadding: EdgeInsets.all(10),
      title: Text("Status"),
      content: Text("Choose the status of the child"),
      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: heightSmall),
            arriveEnabled
                ? CustomElevatedButton(
                    status: "ARRIVED", color: Colors.lightGreen[400])
                : Container(),
            SizedBox(height: heightSmall),
            pickedEnabled
                ? CustomElevatedButton(
                    status: "PICKED", color: Colors.yellow[400])
                : Container(),
            SizedBox(height: heightSmall),
            absentEnabled
                ? CustomElevatedButton(
                    status: "ABSENT", color: Colors.redAccent[200])
                : Container(),
          ],
        )
      ],
    ),
  );
}
