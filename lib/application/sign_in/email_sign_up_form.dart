import 'package:flutter/material.dart';
import 'package:kindermanager/application/form_validator.dart';
import 'package:kindermanager/application/sign_in/email_confirmation_page.dart';
import 'package:kindermanager/application/sign_in/log_in_page.dart';
import 'package:kindermanager/custom_widgets/custom_button.dart';
import 'package:kindermanager/custom_widgets/show_alert_dialog.dart';
import 'package:kindermanager/design_theme.dart';
import 'package:provider/provider.dart';

import '../../services/auth.dart';

/// Widget with text fields and submit button to
/// create a new user.
class EmailSignUpForm extends StatefulWidget {
  const EmailSignUpForm({super.key});

  @override
  _EmailSignUpFormState createState() => _EmailSignUpFormState();
}

class _EmailSignUpFormState extends State<EmailSignUpForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  /// Creates a new user with given email and password.
  void _submit() async {
    final auth = Provider.of<Auth>(
      context,
      listen: false,
    );

    if (!FormValidator.isEmailValid(_emailController.text)) {
      ShowAlertDialog(context,
          title: "Email",
          content: "Please check your email format!",
          rightButtonText: "Ok",
          isDestructive: false);
      _emailController.clear();
      return;
    }

    if (!FormValidator.isPasswordValid(_passwordController.text) ||
        !FormValidator.isPasswordValid(_confirmPasswordController.text)) {
      ShowAlertDialog(context,
          title: "Password",
          content: "Password format is wrong!",
          rightButtonText: "Ok",
          isDestructive: false);
      _passwordController.clear();
      _confirmPasswordController.clear();
      return;
    }

    if (!FormValidator.isPasswordsMatch(
        _passwordController.text, _confirmPasswordController.text)) {
      ShowAlertDialog(context,
          title: "Password ",
          content: "Passwords don't match, try again",
          rightButtonText: "Ok",
          isDestructive: false);
      _passwordController.clear();
      _confirmPasswordController.clear();
      return;
    }

    try {
      await auth.createUserWithEmail(
          _emailController.text, _passwordController.text);
      auth.signOut();
      Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (context) => EmailConfirmationPage(),
      ));
    } catch (e) {
      ShowAlertDialog(context,
          title: "Sign up",
          content: "Sign up failed, check your credentials again!",
          rightButtonText: "Ok",
          isDestructive: false);
      _emailController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
    }
  }

  List<Widget> _buildChildren() {
    return [
      TextField(
        controller: _emailController,
        decoration:
            const InputDecoration(labelText: "Email", hintText: "Enter email"),
      ),
      const SizedBox(
        height: 50.0,
      ),
      TextField(
        controller: _passwordController,
        decoration: const InputDecoration(
            labelText: "Password", hintText: "Enter password"),
        obscureText: true,
      ),
      const SizedBox(
        height: 50.0,
      ),
      TextField(
        controller: _confirmPasswordController,
        decoration: const InputDecoration(
            labelText: "Confirm password", hintText: "Confirm password"),
        obscureText: true,
      ),
      const SizedBox(
        height: 64.0,
      ),
      CustomButton(
        onPressed: _submit,
        backgroundColor: Colors.green,
        height: 52.0,
        child: const Text(
          'Sign up',
          style: TextStyle(fontSize: fontSizeMedium),
        ),
      ),
      const SizedBox(
        height: 16.0,
      ),

      /// Navigates to the LogInPage when pressed.
      TextButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) => const LogInPage(),
            ),
          );
        },
        child: const Text(
          "Already have an account? Log in!",
          style: TextStyle(fontSize: fontSizeMedium),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }
}
