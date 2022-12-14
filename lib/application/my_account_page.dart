/// My account page that shows user information about the current user
/// that is logged into the app.

import 'package:flutter/material.dart';
import 'package:kindermanager/application/sign_in/password_reset_confirmation_page.dart';
import 'package:kindermanager/custom_widgets/custom_button.dart';
import 'package:kindermanager/design_theme.dart';
import 'package:provider/provider.dart';

import '../custom_widgets/show_alert_dialog.dart';
import '../services/auth.dart';

/// Details about the logged in user with
/// password resetting functionality.
class MyAccountPage extends StatelessWidget {
  const MyAccountPage({
    Key? key,
    required this.userName,
  }) : super(key: key);
  final String userName;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      backgroundColor: lightGreen50,
      appBar: AppBar(
        title: const Text("My Account"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: widthMedium),
            child: InkWell(
              onTap: () async {
                final result = await ShowAlertDialog(
                  context,
                  title: "Sign out",
                  content: "Are you sure ?",
                  leftButtonText: "Cancel",
                  rightButtonText: "Logout",
                  isDestructive: true,
                );
                if (result) {
                  auth.signOut();
                  Navigator.pop(context);
                }
              },
              child: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 80.0, right: 80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 80,
              ),
              Image.asset(
                "assets/images/app-icon.png",
                height: 90,
                width: 90,
              ),
              const SizedBox(
                height: heightSmall,
              ),
              Text(userName),
              const SizedBox(
                height: heightSmall,
              ),
              CustomButton(
                child: Text("Change password"),
                backgroundColor: lightGreen300,
                height: heightLarge,
                onPressed: () async {
                  final result = await ShowAlertDialog(context,
                      title: "Reset password",
                      content: "You are going to reset the password!",
                      rightButtonText: "Reset",
                      isDestructive: true,
                      leftButtonText: "Cancel");
                  if (result) {
                    auth.onResetPassword(userName);
                    auth.signOut();
                    Navigator.of(context).push(MaterialPageRoute<void>(
                      builder: (context) => PasswordResetConfirmationPage(),
                    ));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
