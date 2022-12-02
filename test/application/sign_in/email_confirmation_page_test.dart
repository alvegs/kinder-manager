import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kindermanager/application/sign_in/email_confirmation_page.dart';
import 'package:kindermanager/custom_widgets/custom_button.dart';

/// This class is for testing the widgets in email confirmation page class.
/// The point is to see that the widgets contains the expected elements and
/// are built correct.

void main() {
  testWidgets('checks elements in email confirmation page is present', (tester) async {
    // for building and rendering the widget
    await tester.pumpWidget(MaterialApp(home: const EmailConfirmationPage()),
    );
    final button = find.byType(CustomButton);
    // expected to find 2 CustomRaisedButtons in EmailConf. widget
    expect(button, findsNWidgets(2));
    expect(find.byType(TextButton), findsNothing);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    // checks that these texts are in the widget
    expect(find.text("Please check your inbox for a confirmation email. Click the link in the email to confirm your email address."), findsOneWidget);
    expect(find.text("Back to login"), findsOneWidget);
    expect(find.text("Re-send confirmation email"), findsOneWidget);
  });
}