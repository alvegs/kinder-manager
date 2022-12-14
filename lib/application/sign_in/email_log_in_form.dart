import 'package:flutter/material.dart';
import 'package:kindermanager/application/form_validator.dart';
import 'package:kindermanager/application/sign_in/forgot_password_page.dart';

import 'package:kindermanager/application/sign_in/sign_up_page.dart';
import 'package:kindermanager/custom_widgets/custom_button.dart';
import 'package:kindermanager/design_theme.dart';
import 'package:provider/provider.dart';
import '../../custom_widgets/show_alert_dialog.dart';
import '../../services/auth.dart';
import '../landing_page.dart';

class EmailLogInForm extends StatefulWidget {
  const EmailLogInForm({super.key});

  @override
  _EmailLogInFormState createState() => _EmailLogInFormState();
}

class _EmailLogInFormState extends State<EmailLogInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submit() async {
    final auth = Provider.of<Auth>(
      context,
      listen: false,
    );
    if (!FormValidator.isEmailValid(_emailController.text)) {
      ShowAlertDialog(context,
          title: "Email failed",
          content: "Please check your email format and try again!",
          rightButtonText: "Ok",
          isDestructive: false);
      _emailController.clear();
      return;
    }
    if (!FormValidator.isEmailValid(_emailController.text)) {
      ShowAlertDialog(context,
          title: "Password failed",
          content: "Please check your password and try again!",
          rightButtonText: "Ok",
          isDestructive: false);
      _passwordController.clear();
      return;
    }

    try {
      final isVerified = await auth.isEmailVerified(
          _emailController.text, _passwordController.text);

      Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (context) => LandingPage(),
      ));
    } catch (e) {
      ShowAlertDialog(context,
          title: "Sign in failed",
          content: "Please check your credentials and try again!",
          rightButtonText: "Ok",
          isDestructive: false);
      _emailController.clear();
      _passwordController.clear();
      return;
    }
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

  List<Widget> _buildChildren() {
    return [
      TextField(
        key: Key("emailInputTextField"),
        controller: _emailController,
        decoration:
            const InputDecoration(labelText: "Email", hintText: "Enter email"),
        keyboardType: TextInputType.emailAddress,
      ),
      const SizedBox(
        height: 50.0,
      ),
      TextField(
        key: Key("passwordInputTextField"),
        controller: _passwordController,
        decoration: const InputDecoration(
            labelText: "Password", hintText: "Enter password"),
        obscureText: true,
      ),
      const SizedBox(
        height: 64.0,
      ),
      CustomButton(
        key: Key("loginSubmitButton"),
        onPressed: _submit,
        height: 52.0,
        backgroundColor: Colors.green,
        child: const Text(
          'Log in',
          style: TextStyle(fontSize: fontSizeMedium),
        ),
      ),
      const SizedBox(
        height: 16.0,
      ),
      TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => const ForgotPasswordPage(),
              ),
            );
          },
          child: const Text(
            "Forget password ?",
            style: TextStyle(fontSize: fontSizeMedium),
          )),
      TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => const SignInPage(),
              ),
            );
          },
          child: const Text(
            "Don't have an account? Sign up!",
            style: TextStyle(fontSize: fontSizeMedium),
          )),
    ];
  }
}
