import 'package:flutter/material.dart';

/// Default button to use in the app.
class CustomRaisedButton extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final double borderRadius;
  final VoidCallback? onPressed;
  final double height;

  /// Creates an instance of button with custom
  /// border radius and height.
  const CustomRaisedButton({
    Key? key,
    required this.child,
    required this.backgroundColor,
    this.borderRadius = 2.0,
    this.onPressed,
    this.height = 50.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
