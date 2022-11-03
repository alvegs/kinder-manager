import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kindermanager/application/sections_page.dart';
import 'package:kindermanager/application/sign_in/log_in_page.dart';
import 'package:kindermanager/services/firebase_database.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';

/// Landing page of the app when the user opens the app,
/// with log in and sign up possibilities.
class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Accessing the firebase authorization.
    final auth = Provider.of<Auth>(
      context,
      listen: false,
    );

    /// Checks user state and
    /// displays a page accordingly.
    return StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          final User? user = snapshot.data;
          if (user == null) {
            return LogInPage();
          }
          return Provider<FirebaseDatabase>(
            create: (_) => FirebaseDatabase(),
            child: const SectionsPage(),
          );
        });
  }
}
