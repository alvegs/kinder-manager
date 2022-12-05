import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kindermanager/custom_widgets/custom_elevated_button.dart';
import 'package:kindermanager/custom_widgets/custom_button.dart';

/// Since the code in custom_button_test and in custom_elevated_button
/// were too similar they will be combined in one test.
void main() {
  // Sets an predefines color to be used on the tests.
  var color = Colors.lightGreen[50];
  // Holds the status if the onPressed action were called.
  var pressed = false;
  // Holds the text
  var text = "tap me";
  // Holds the button height
  var buttonHeight = 10.0;

  // Predefined materialApp to prevent too much duplication of code.
  // This alternative got no onPressed Action.
  var customElevatedButtonWidget = MaterialApp(
      home: CustomElevatedButton(
    status: text,
    color: color,
  ));

  // Predefined materialApp for the Custom_Button class
  // to prevent too much duplication of code.
  // This alternative got no onPressed Action.
  var customButtonWidget = MaterialApp(
    home: CustomButton(
      child: Text(text),
      backgroundColor: color,
      height: buttonHeight,
      onPressed: () {
        if (pressed == true) {
          pressed = false;
        } else {
          pressed = true;
        }
      },
    ),
  );

  // Predefined materialApp for the Custom_Button class
  // to prevent too much duplication of code.
  // This alternative got no onPressed Action.
  var customButtonWidgetWithoutOnPressedAction = MaterialApp(
    home: CustomButton(
      child: Text(text),
      backgroundColor: color,
      height: buttonHeight,
    ),
  );

  // Testing the custom elevated button class
  group('Custom Elevated Button tests', () {
// Checks if a button can be found.
    testWidgets("button exist", (WidgetTester tester) async {
      await tester.pumpWidget(customElevatedButtonWidget);
      final button = find.byType(CustomElevatedButton);
      expect(button, findsOneWidget);
      expect(find.byType(TextButton), findsNothing);
    });
// checks that there is a text in the widget.
    testWidgets("text on button exist", (WidgetTester tester) async {
      await tester.pumpWidget(customElevatedButtonWidget);
      expect(find.text('tap me'), findsOneWidget);
    });
// Checks that the color set is the one used.
    testWidgets("color on button is correct", (WidgetTester tester) async {
      await tester.pumpWidget(customElevatedButtonWidget);
      final button = tester
          .widget<CustomElevatedButton>(find.byType(CustomElevatedButton));
      expect(button.color, equals(color));
    });
  });

  // Testing the custom button class
  group('custom button tests', () {
    testWidgets('Test custom raised button "on pressed" action',
        (WidgetTester tester) async {
      await tester.pumpWidget(customButtonWidget);
      final button = find.byType(ElevatedButton);
      // awaiting tap action on the button - turns from false to true and vice versa
      await tester.tap(button);
      expect(pressed, true);
      await tester.tap(button);
      expect(pressed, false);
    });

    testWidgets('test background color on button', (WidgetTester tester) async {
      await tester.pumpWidget(customButtonWidgetWithoutOnPressedAction);
      final button = tester.widget<CustomButton>(find.byType(CustomButton));
      expect(button.backgroundColor, equals(color));
      expect(find.text(text), findsOneWidget);
    });
  });
}
