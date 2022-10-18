import 'package:flutter/material.dart';

import '../common_widgets/custom_raised_button.dart';

/// Landing page of the app when the user opens the app,
/// with log in and sign up possibilities.
class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// todo check whether the user is logged in return HomePage,
    /// todo otherwise return this scaffold.
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kinder Manager"),
      ),

      /// Setting padding using Padding widget.
      body: Padding(
        padding: const EdgeInsets.all(56.0),

        /// Widget with app name and buttons to log in and sign up.
        /// Sized box widget is used to apply space between widgets.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Displaying app name.
            const Text(
              "Kinder",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreen),
            ),

            /// Vertical spacing
            const SizedBox(height: 4),

            /// Displaying app name.
            const Text(
              "Manager",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),

            /// todo make logo.

            /// Vertical spacing
            const SizedBox(
              height: 36,
            ),

            /// Button displaying log in
            CustomRaisedButton(
              height: 52,
                backgroundColor: Colors.lightGreen,
                onPressed: () {},
                child: const Text(
                  "Log in",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),

            /// Vertical spacing
            const SizedBox(
              height: 24,
            ),

            /// Button displaying sign up.
            CustomRaisedButton(
              height: 52,
                onPressed: () {},
                backgroundColor: Colors.lightGreen,
                child: const Text(
                  "Sign up",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
