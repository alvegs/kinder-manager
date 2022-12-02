import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kindermanager/custom_widgets/section_display_widget.dart';
import 'package:kindermanager/model/section.dart';
import 'package:network_image_mock/network_image_mock.dart';

/**
 * Class for testing a widget that displays a section in the home page
 * after login is complete.
 */


Widget makeTestableWidget() => MaterialApp(home: Image.network(''));

void main() {
  testWidgets('test on pressed functions in Section Display Widget', (WidgetTester tester) async {
    final section = Section(
        name: "test id",
        id: "test name",
        imageFile: "assets/images/cartoon.jpeg");
    var pressed = false;
    var onLongPressed = false;
    await mockNetworkImagesFor(() => tester.pumpWidget(makeTestableWidget()));
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SectionDisplay(
            section: section,
            onPressed: () {
              if (pressed == false) {
                pressed = true;
              } else {
                pressed = false;
              }
            },
            onLongPressed: () {
              if (onLongPressed == false) {
                onLongPressed = true;
              } else {
                onLongPressed = false;
              }
            },
          ),
        ),
      ),
    );
  final inkWell = find.byType(InkWell);
  expect(inkWell, findsOneWidget);
  await tester.tap(inkWell);
  expect(pressed, true);
  await tester.tap(inkWell);
  expect(pressed, false);



  });
}
