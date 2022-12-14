import 'package:flutter/material.dart';
import 'package:kindermanager/application/form_validator.dart';
import 'package:kindermanager/application/sign_in/log_in_page.dart';
import 'package:kindermanager/application/sign_in/password_reset_confirmation_page.dart';
import 'package:kindermanager/custom_widgets/custom_button.dart';
import 'package:kindermanager/custom_widgets/show_alert_dialog.dart';
import 'package:kindermanager/design_theme.dart';
import 'package:provider/provider.dart';

import '../../services/auth.dart';

/// This page is to be displayed when the "forgot password" text is clicked
/// on the "sign in"-page.
class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final auth = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      backgroundColor: lightGreen50,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
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
            TextField(
              controller: _emailController,
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
              onPressed: () async {
                final isEmailValid =
                    FormValidator.isEmailValid(_emailController.text);
                final isEmailFound =
                    await auth.onResetPassword(_emailController.text);
                if (isEmailValid && isEmailFound) {
                  auth.onResetPassword(_emailController.text);

                  Navigator.of(context).push(MaterialPageRoute<void>(
                    builder: (context) => const PasswordResetConfirmationPage(),
                  ));
                } else {
                  ShowAlertDialog(
                    context,
                    title: "Error",
                    content: "Please check your email",
                    rightButtonText: "Ok",
                    isDestructive: false,
                  );
                  _emailController.clear();
                }
              },
              height: 52,
              backgroundColor: Colors.green,
              child: const Text(
                "Reset password",
              ),
            ),
            const SizedBox(
              height: heightMedium,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => const LogInPage(),
                  ),
                );
              },
              child: const Text(
                "Back to login",
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
