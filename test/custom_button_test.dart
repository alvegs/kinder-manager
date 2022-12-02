import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kindermanager/custom_widgets/custom_button.dart';

/// Testing the custom button class

void main() {
  testWidgets('Test custom raised button onpressed action', (WidgetTester tester) async {
    var pressed = false;
    var buttonColor =
    await tester.pumpWidget(
        MaterialApp(
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
        ),
    );
    final button = find.byType(ElevatedButton);
    // awaiting tap action on the button - turns from false to true and vice versa
    await tester.tap(button);
    expect(pressed, true);
    await tester.tap(button);
    expect(pressed, false);
  });
}