import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:kindermanager/application/sign_in/email_log_in_form.dart';

void main() {
  testWidgets('check if image is found', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(
          home: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset("assets/images/KM_logo.png"),
                EmailLogInForm(),
              ],
            ),
          ),
        )
    );
  });

  //TODO: Either remove this test class or complete it.
}