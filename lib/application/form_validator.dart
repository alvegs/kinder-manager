///  Provides methods to validate fields used in the app.
class FormValidator {

  /// Validates the given string,
  /// Returns true if it matches the conditions,
  /// false otherwise
  static bool isNameValid(String? name) {
    return name!.isNotEmpty && name.length >= 3 && name.length < 24;
  }

  /// Compares two given strings.
  /// Returns true if strings are identical,
  ///  false otherwise.
  static bool isPasswordsMatch(String? password, String? confirmPassword) {
    return password == confirmPassword;
  }

  /// Validates the given password and
  /// Returns true if it matches the conditions,
  /// false otherwise.
  static bool isPasswordValid(String password) {
    return password.isNotEmpty &&
        password.length >= 6 &&
        password.length <= 20 &&
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])').hasMatch(password);
  }

  /// Validates the given email.
  /// Returns true if email is valid,
  /// false otherwise.
  static bool isEmailValid(String email) {
    return email.isNotEmpty &&
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email);
  }
}
