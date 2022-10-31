import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kindermanager/application/email_confirmation_page.dart';
import 'package:kindermanager/application/forgot_password_page.dart';
import 'package:kindermanager/application/landing_page.dart';
import 'package:kindermanager/application/section_start_page.dart';
import 'package:kindermanager/application/sign_in/log_in_page.dart';

import 'package:kindermanager/application/sign_in/sign_in_page.dart';
import 'package:kindermanager/services/auth.dart';

import 'application/home_page.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<Auth>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        home: const LandingPage(),
      ),
    );
  }
}
