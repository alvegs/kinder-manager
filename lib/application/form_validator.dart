import 'package:string_validator/string_validator.dart';

class FormValidator {
  static bool isNameValid(String? name) {
    return isAlpha(name!) &&
        name.isNotEmpty &&
        name.length >= 3 &&
        name.length < 13;
  }

  static bool isPasswordsMatch(String? password, String? confirmPassword) {
    return password == confirmPassword;
  }

  static bool isPasswordValid(String password) {
    return password.isNotEmpty &&
        password.length >= 6 &&
        password.length <= 20 &&
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])').hasMatch(password);
  }

  static bool isEmailValid(String email) {
    return email.isNotEmpty &&
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email);
  }
}


