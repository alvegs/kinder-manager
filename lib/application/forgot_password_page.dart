import 'package:flutter/material.dart';
import 'package:kindermanager/common_widgets/custom_raised_button.dart';

/// This page is to be displayed when the "forgot password" text is clicked
/// on the "sign in"-page.

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
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
              height: 20,
            ),
            const Text(
              "Enter the email address associated with your account",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            // Text field entry for email address
            const SizedBox(
              height: 20,
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "email address",
              ),
            ),
            // Button
            const SizedBox(
              height: 20,
            ),
            CustomRaisedButton(
              onPressed: () {},
              backgroundColor: Colors.green,
              child: Text(
                "Send",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Back to login",
            textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}
