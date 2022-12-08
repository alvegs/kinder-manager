import 'package:flutter/material.dart';
import 'package:kindermanager/application/sign_in/log_in_page.dart';
import 'package:kindermanager/custom_widgets/custom_button.dart';
import 'package:kindermanager/custom_widgets/show_alert_dialog.dart';
import 'package:kindermanager/design_theme.dart';
import 'package:provider/provider.dart';

import '../../services/auth.dart';

/// This page is for confirming your email address after signing up
class EmailConfirmationPage extends StatelessWidget {
  const EmailConfirmationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(
      context,
      listen: false,
    );
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
              "Please check your inbox for a confirmation email. Click the link "
                  "to confirm your email address. "
                  "Remember to check your spam folder !",
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
              backgroundColor: Colors.green[100],
              height: 52,
              child: const Text("Resend mail"),
              onPressed: () async {
                final user = await auth.currentUser();
                if (user != null && !user.emailVerified) {
                  await user.sendEmailVerification();
                  ShowAlertDialog(context,
                    title: "Email" ,
                    content: "We have sent a new verification mail to your email.",
                    rightButtonText: "Ok",
                    isDestructive: false,);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
