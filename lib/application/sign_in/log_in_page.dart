import 'package:flutter/material.dart';
import 'package:kindermanager/application/sign_in/email_log_in_form.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
     return Scaffold(
      /* appBar: AppBar(
        title: const Text("Log in page"),
      ),*/
      body: _buildContent(),
    );
  }

  Padding _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text(
            "KM",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 80.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "Welcome to Kinder!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(
            height: 20.0,
          ),

          //ToDo: Implement sign up form...
          EmailLogInForm(),

          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}