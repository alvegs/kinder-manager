abstract class StringValidator {
  bool isValid(String value);
}

abstract class EmailValidator {
  bool isValid(String value);
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return false;
    } else {
      return value.isNotEmpty;
    }
  }
}

class NonEmptyEmailValidator implements EmailValidator {
  @override
  bool isValid(String value){
    if (value.isEmpty || value.length < 4 || value.trim().isEmpty || (!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?)*$").hasMatch(value))) {
      return false;
    } else {
      return value.isNotEmpty;
    }
  }
}

class EmailAndPasswordValidators {
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();
  final String invalidEmailErrorText = 'Email can\'t be empty';
  final String invalidPasswordErrorText = 'Password can\'t be empty';
}
