import 'package:flutter/material.dart';

/// Custom elevated button to use in status dialog box.
class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {Key? key, required this.status, required this.color})
      : super(key: key);
  /// Status text to be displayed
  final String status;
  /// Color of the button
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      /// Returns the value chosen.
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
          padding: MaterialStatePropertyAll(EdgeInsets.all(16)),
        ),
        onPressed: () => Navigator.of(context).pop(status),
        child: Text(status),
      ),
    );
  }
}
