import 'package:flutter/material.dart';

import 'package:kindermanager/application/sign_in/sign_up_page.dart';
import 'package:kindermanager/custom_widgets/custom_button.dart';
import 'package:provider/provider.dart';
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
    try {
      await auth.signInWithEmail(
        _emailController.text,
        _passwordController.text,
      );
      Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (context) => LandingPage(),
      ));
    } catch (e) {

    }
  }

  List<Widget> _buildChildren() {
    return [
      TextField(
        controller: _emailController,
        decoration: const InputDecoration(
            labelText: "Email", hintText: "Test@test.com"),
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
        height: 64.0,
      ),
      CustomRaisedButton(
        onPressed: _submit,
        height: 52.0,
        backgroundColor: Colors.green,
        child: const Text('Log in'),
      ),
      const SizedBox(
        height: 16.0,
      ),
      TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => const SignInPage(),
              ),
            );
          },
          child: const Text("Don't have an account? Sign up!")),
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
