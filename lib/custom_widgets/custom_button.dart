import 'package:flutter/material.dart';

/// Default button to use in the app.
class CustomButton extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final double borderRadius;
  final VoidCallback? onPressed;
  final double height;

  /// Creates an instance of button with predefined
  /// border radius.
  const CustomButton({
    Key? key,
    required this.child,
    required this.backgroundColor,
    this.borderRadius = 2.0,
    this.onPressed,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
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
