import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kindermanager/custom_widgets/custom_button.dart';

/// Testing the custom button class

void main() {
  // setting up widget before tests
  var pressed = false;
  var customButton = MaterialApp(
    home: CustomButton(
      child: Text("tap me"),
      backgroundColor: Colors.lightGreen[50],
      height: 10,
      onPressed: () {
        if (pressed == true) {
          pressed = false;
        } else {
          pressed = true;
        }
      },
    ),
  );

  testWidgets('Test custom raised button "on pressed" action', (WidgetTester tester) async {
    await tester.pumpWidget(customButton);
    final button = find.byType(ElevatedButton);
    // awaiting tap action on the button - turns from false to true and vice versa
    await tester.tap(button);
    expect(pressed, true);
    await tester.tap(button);
    expect(pressed, false);
  });

  testWidgets('test background color and text on button', (WidgetTester tester) async {
    await tester.pumpWidget(customButton);
    final button = tester.widget<CustomButton>(find.byType(CustomButton));
    expect(button.backgroundColor, equals(Colors.lightGreen[50]));
    expect(find.text("tap me"), findsOneWidget);
  });

}