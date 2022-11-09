/// My account page that shows user information about the current user
/// that is logged into the app.

import 'package:flutter/material.dart';

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Account"),
        leading: IconButton(
          icon:  const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 200,
            ),
            Image.asset(
              "assets/images/cartoon.jpeg",
              height: 90,
              width: 90,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("name: username"),
            const SizedBox(
              height: 10,
            ),
            const Text("Department: department"),

          ],
        ),
      ),
    );
  }
}
