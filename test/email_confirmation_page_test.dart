import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kindermanager/application/sign_in/email_confirmation_page.dart';
import 'package:kindermanager/custom_widgets/custom_button.dart';

/// This class is for testing the widgets in email confirmation page class.
/// The point is to see that the widgets contains the expected elements and
/// are built correct.

void main() {
  testWidgets('description', (tester) async {
    // for building and rendering the widget
    await tester.pumpWidget(MaterialApp(home: const EmailConfirmationPage()),
    );
    final button = find.byType(CustomRaisedButton);
    // expected to find 2 CustomRaisedButtons in EmailConf. widget
    expect(button, findsNWidgets(2));
    expect(find.byType(TextButton), findsNothing);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
  });
}