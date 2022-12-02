import 'package:flutter/material.dart';
import 'package:kindermanager/application/sign_in/email_sign_up_form.dart';
import 'package:kindermanager/design_theme.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign up page"),
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              "Sign up",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Create an account",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSizeSmaller,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(
              height: heightMedium,
            ),

            //ToDo: Implement sign up form...
            EmailSignInForm(),

            SizedBox(
              height: heightMedium,
            ),
          ],
        ),
      ),
    );
  }
}
