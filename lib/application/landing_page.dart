import 'package:flutter/material.dart';

import '../common_widgets/custom_raised_button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kinder Manager"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(56.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Kinder",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreen),
            ),
            const SizedBox(height: 4),
            const Text(
              "Manager",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),

            /// todo make logo.

            const SizedBox(
              height: 36,
            ),
            CustomRaisedButton(
                backgroundColor: Colors.lightGreen,
                onPressed: () {},
                child: const Text(
                  "Log in",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
            const SizedBox(
              height: 24,
            ),
            CustomRaisedButton(
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
