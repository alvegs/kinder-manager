import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kindermanager/application/sign_in/sign_up_page.dart';

/// Class serves as a tester for SignUpPage.

void main() {
  testWidgets('', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SignInPage()),
    );
  });

  //TODO: implement test logic in this class

}