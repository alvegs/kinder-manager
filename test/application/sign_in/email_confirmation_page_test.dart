import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kindermanager/application/sign_in/email_confirmation_page.dart';
import 'package:kindermanager/custom_widgets/custom_button.dart';

/**
 * Class for testing the widget email confirmation page.
 */

void main() {
  testWidgets('check 2 custom buttons present', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EmailConfirmationPage(),
      ),
    );
    final button = find.byType(CustomButton);
    expect(button, findsNWidgets(2));
  });

  testWidgets('text button not present', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EmailConfirmationPage(),
      ),
    );
    expect(find.byType(TextButton), findsNothing);
  });

  testWidgets('text on page is correct', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EmailConfirmationPage(),
      ),
    );
    expect(
        find.text(
            "Please check your inbox for a confirmation email. Click the link in the email to confirm your email address."),
        findsOneWidget);
    expect(find.text("Back to login"), findsOneWidget);
    expect(find.text("Re-send confirmation email"), findsOneWidget);
  });
}
