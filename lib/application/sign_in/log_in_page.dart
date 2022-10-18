import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kindermanager/application/sign_in/email_log_in_form.dart';
import 'package:kindermanager/application/sign_in/email_sign_in_form.dart';

import '../../common_widgets/custom_raised_button.dart';

class LogInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log in page"),
      ),
      body: _buildContent(),
    );
  }

  Padding _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "KM",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 80.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Text(
            "Welcome to Kinder!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(
            height: 20.0,
          ),

          //ToDo: Implement sign up form...
          EmailLogInForm(),

          const SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}