/// My account page that shows user information about the current user
/// that is logged into the app.

import 'package:flutter/material.dart';
import 'package:kindermanager/custom_widgets/custom_button.dart';
import 'package:kindermanager/custom_widgets/custom_elevated_button.dart';
import 'package:kindermanager/design_theme.dart';

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({Key? key, required this.userName}) : super(key: key);
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGreen50,
      appBar: AppBar(
        title: const Text("My Account"),
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
                onPressed: (){},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
