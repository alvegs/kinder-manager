import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kindermanager/application/landing_page.dart';
import 'package:kindermanager/main.dart' as app;

/**
 * Integration test for the application that tests the app as a whole application.
 */
Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  var _username = "";
  var _password = "";

  // Since the credentials file might be either empty or not correctly setup,
  // we will try to perform the email and password retrieval and potentially catch the exception.
  try {
    // Retrieves the credentials.csv file.
    final credentialFile = await rootBundle.loadString('assets/text/credentials.csv');
    // Splits the credentialFile by "next line" and adds both of them to the credentials list.
    var credentials = credentialFile
        .split("\n")
        .map((x) => x.trim())
        .where((element) => element.isNotEmpty)
        .toList();

    // If the length is any shorter or any longer,
    // the credentials.csv file is either empty or not corretly setup.
    if (credentials.length == 2) {
      _username = credentials[0];
      _password = credentials[1];
    }
    // Catch everything and do nothing.
  } on Exception catch (_) {}



//
  group('integration test', () {
    testWidgets('login test', (tester) async {
      app.main();
      // Changes the test window size
      tester.binding.window.physicalSizeTestValue = const Size(400, 943.9);
      await tester.pumpAndSettle(const Duration(seconds: 4));

      // We expect the login page to contain a
      // email input field,
      // a password input field and
      // a login button and a sign up button.
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Log in'), findsOneWidget);
      expect(find.text("Don't have an account? Sign up!"), findsOneWidget);

      // Checks if the email input field can be found and also if we can write in the field
      await tester.tap(find.byKey(const Key('emailInputTextField')), warnIfMissed: false);
      // enters the email address to the email input field.
      await tester.enterText(find.byKey(const Key('emailInputTextField')), _username);
      // Rebuild widgets that need to be rebuilt and are called until no new frames are scheduled
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Checks if it can find the password input field and also if we can write in the field
      var passwordInput = find.byKey(const Key('passwordInputTextField'));
      // Checks if the password input field can be found and also if we can write in the field
      await tester.tap(passwordInput, warnIfMissed: false);
      // enters the password address to the email input field.
      await tester.enterText(passwordInput, _password);
      // Rebuild widgets that need to be rebuilt and are called until no new frames are scheduled.
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Checks that there is a login button and clicks on it.
      var loginButton = find.byKey(const Key('loginSubmitButton'));
      // Since there might be something covering the login button,
      // drag the screen until the widget is visible.
      await tester.dragUntilVisible(
        loginButton, // wait until this is visible
        find.byType(SingleChildScrollView), // the widget to scroll
        const Offset(0, 50), // the offset to move
      );
      // Taps the login button.
      await tester.tap(loginButton, warnIfMissed: false);
      // Rebuild widgets that need to be rebuilt and are called until no new frames are scheduled.
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Rebuild widgets that need to be rebuilt and are called until no new frames are scheduled.
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();
      // Checks that it can access the landingPage after login.
      expect(find.byWidgetPredicate((widget) => widget is LandingPage),
          findsOneWidget);
      // Login is now complete

      // Rebuild widgets that need to be rebuilt and are called until no new frames are scheduled.
      await tester.pumpAndSettle();
      // Checks that the button is visible
      await tester.ensureVisible(find.byKey(const Key("logoutButton")));
      // Checks that the logout button is found.
      expect(find.byKey(const Key("logoutButton")), findsOneWidget);
      // Taps the button
      await tester.tap(find.byKey(const Key("logoutButton")));
      // Rebuild widgets that need to be rebuilt and are called until no new frames are scheduled.
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();
    });
  });
}
