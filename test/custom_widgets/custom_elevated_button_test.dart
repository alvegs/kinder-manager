import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kindermanager/custom_widgets/custom_elevated_button.dart';

/// Testing the custom elevated button class
void main() {
  // Sets an predefines color to be used on the tests.
  var color = Colors.indigo;
  // Predefines the widget to prevent code duplication.
  var widget = MaterialApp(
      home: CustomElevatedButton(
        status: 'tap me',
        color: color,
      )
  );

// Checks if a button can be found.
  group('Custom Elevated Button tests', () {
    testWidgets("button exist", (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      final button = find.byType(CustomElevatedButton);
      expect(button, findsOneWidget);
      expect(find.byType(TextButton), findsNothing);
    });
// checks that there is a text in the widget.
    testWidgets("text on button exist", (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      expect(find.text('tap me'), findsOneWidget);
    });
// Checks that the color set is the one used.
    testWidgets("color on button is correct", (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      final button = tester
          .widget<CustomElevatedButton>(find.byType(CustomElevatedButton));
      expect(button.color, equals(Colors.indigo));
    });
  });
}
