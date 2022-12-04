import 'dart:math';
import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kindermanager/application/landing_page.dart';
import 'package:kindermanager/application/sign_in/email_log_in_form.dart';

import 'package:kindermanager/main.dart' as app;


  Future<void> main() async {
    final login = EmailLogInForm();
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    TestWidgetsFlutterBinding.ensureInitialized();
    WidgetsFlutterBinding.ensureInitialized();

    var path = 'assets/text/credentials.csv';
    var _username = "";
    var _password = "";
    final configFile = await rootBundle.loadString(path);

    var credentials = configFile.split("\n").map((x)
    => x.trim()).where((element) => element.isNotEmpty).toList();

    if (credentials.length == 2){
      _username = credentials[0];
      _password = credentials[1];
    }


  group('end-to-end test', () {
    testWidgets('login test', (tester) async {
      app.main();
      //tester.binding.window.physicalSizeTestValue = const Size(1024, 768);
      tester.binding.window.physicalSizeTestValue = const Size(400, 943.9);
      await tester.pumpAndSettle();
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Log in'), findsOneWidget);
      expect(find.text("Don't have an account? Sign up!"), findsOneWidget);

      // Checks if it can find the email input field and also if we can write in the field
      var emailInput = find.byKey(const Key('emailInputTextField'));
      await tester.tap(emailInput);
      await tester.enterText(emailInput, _username);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Checks if it can find the password input field and also if we can write in the field
      var passwordInput = find.byKey(const Key('passwordInputTextField'));
      await tester.tap(passwordInput);
      await tester.enterText(passwordInput, _password);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Checks that there is a login button and clicks on it.
      var loginButton = find.byKey(const Key('loginSubmitButton'));
     // await tester.ensureVisible(find.byKey(Key("loginSubmitButton")));
      await tester.dragUntilVisible(
        loginButton, // what you want to find
        find.byType(SingleChildScrollView), // widget you want to scroll
        const Offset(0, 50), // delta to move
      );

      await tester.tap(loginButton, warnIfMissed: false);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.pump(const Duration(milliseconds: 4000));
      await tester.pumpAndSettle();
    // Checks that it can access the landingPage after login.
      expect(find.byWidgetPredicate((widget) => widget is LandingPage),
          findsOneWidget);

    });
  });
}
