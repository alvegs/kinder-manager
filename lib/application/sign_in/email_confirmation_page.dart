import 'package:flutter/material.dart';
import 'package:kindermanager/common_widgets/custom_button.dart';

/// This page is for confirming your email address after signing up

class EmailConfirmationPage extends StatelessWidget {
  const EmailConfirmationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // confirm your email text
            const Text(
              "Confirm your Email",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 56,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            // for space between elements
            const SizedBox(
              height: 20,
            ),
            // information text
            const Text(
              "Please check your inbox for a confirmation email. Click the link in the email to confirm your email address.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            // back to login button
            CustomRaisedButton(
              backgroundColor: Colors.green,
              height: 52,
              child: const Text("Back to login"),
              onPressed: () {},
            ),
            const SizedBox(
              height: 20,
            ),
            CustomRaisedButton(
              backgroundColor: Colors.lightGreen,
              height: 52,
              onPressed: () {},
              child: const Text(
                "Re-send confirmation email",
              ),
            ),
          ],
        ),
      ),
    );
  }
}