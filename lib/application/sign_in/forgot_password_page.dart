import 'package:flutter/material.dart';
import 'package:kindermanager/custom_widgets/custom_button.dart';
import 'package:kindermanager/design_theme.dart';

/// This page is to be displayed when the "forgot password" text is clicked
/// on the "sign in"-page.

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:  <Widget>[
            // the forgot password text
            const Text(
              "Forgot Password?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 48,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            // enter email address text
            const SizedBox(
              height: heightMedium,
            ),
            const Text(
              "Enter the email address associated with your account",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSizeLarge,
              ),
            ),
            // Text field entry for email address
            const SizedBox(
              height: heightMedium,
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "email address",
              ),
            ),
            // Button
            const SizedBox(
              height: heightMedium,
            ),
            CustomButton(
              onPressed: () {},
              height: 52,
              backgroundColor: Colors.green,
              child: const Text(
                "Send",
              ),
            ),
            const SizedBox(
              height: heightSmall,
            ),
            const Text("Back to login",
            textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}
