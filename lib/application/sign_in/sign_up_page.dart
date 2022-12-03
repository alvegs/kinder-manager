import 'package:flutter/material.dart';
import 'package:kindermanager/application/sign_in/email_sign_up_form.dart';
import 'package:kindermanager/design_theme.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: heightLarge),
            Image.asset(
              "assets/images/KM_logo.png",
              height: 200,
            ),
            SizedBox(height: heightMedium),
            Text(
              "Sign up",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSizeLarger,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: heightMedium),
            EmailSignUpForm(),
          ],
        ),
      ),
    );
  }
}
