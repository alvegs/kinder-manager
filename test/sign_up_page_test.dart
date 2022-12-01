import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kindermanager/application/sign_in/sign_up_page.dart';
import 'package:kindermanager/custom_widgets/custom_button.dart';

/// Class serves as a tester for SignUpPage.

void main() {
  testWidgets('', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SignInPage()),
    );
    // check that we find one button (sign up)
    final button = find.byType(CustomRaisedButton);
    expect(button, findsOneWidget);
    // check one clickable text is found
    expect(find.byType(TextButton), findsOneWidget);
  });

  //TODO: implement test logic in this class

}