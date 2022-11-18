import 'package:string_validator/string_validator.dart';

class FormValidator {
  static bool isNameValid(String? name) {
    return isAlpha(name!) &&
        name.isNotEmpty &&
        name.length >= 3 &&
        name.length < 13;
  }
}
