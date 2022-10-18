import 'package:flutter/material.dart';
import '../../common_widgets/form_submit_button.dart';

class EmailLogInForm extends StatefulWidget{
  @override _EmailLogInFormState createState() => _EmailLogInFormState();
}

class _EmailLogInFormState extends State<EmailLogInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submit() {
    //ToDo: Print email and password
    print("email: ${_emailController.text} ");
    print("Password: ${_passwordController.text} ");
  }

  List<Widget> _buildChildern() {
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
      FormSubmitButton(
        onPressed: _submit,
        text: 'Sign up!',
      ),
      const SizedBox(
        height: 16.0,
      ),
      TextButton(
          onPressed: () {},
          child: const Text("Already have an account? Log in!")),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildern(),
      ),
    );
  }
}
