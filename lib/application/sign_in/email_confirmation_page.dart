import 'package:flutter/material.dart';
import 'package:kindermanager/application/sign_in/log_in_page.dart';
import 'package:kindermanager/custom_widgets/custom_button.dart';
import 'package:kindermanager/design_theme.dart';

/// This page is for confirming your email address after signing up

class EmailConfirmationPage extends StatelessWidget {
  const EmailConfirmationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
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
              height: heightMedium,
            ),
            // information text
            const Text(
              "Please check your inbox for a confirmation email. Click the link in the email to confirm your email address.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSizeSmall,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            // back to login button
            CustomButton(
              backgroundColor: Colors.green,
              height: 52,
              child: const Text("Back to login"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute<void>(
                  builder: (context) => LogInPage(),
                ));
              },
            ),
            const SizedBox(
              height: heightMedium,
            ),
            CustomButton(
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
