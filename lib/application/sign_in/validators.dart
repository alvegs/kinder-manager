import 'package:flutter/cupertino.dart';
import 'package:kindermanager/model/child.dart';

/// Abstract class that shall act like the skeleton for a validator class for string inputs.
abstract class StringValidator {
  bool isValid(String value);
}

/// Abstract class that shall act like the skeleton for a validator class for email inputs.
abstract class EmailValidator {
  bool isValid(String value);
}

/// Abstract class that shall act like the skeleton for a validator class for name inputs.
abstract class NameValidator {
  bool isValid(String value);
}

/// Abstract class that shall act like the skeleton for a validator class for id inputs.
abstract class IdValidator {
  bool isValid(String value);
}

/// Abstract class that shall act like the skeleton for a validator class for status inputs.
abstract class StatusValidator {
  bool isValid(Status value);
}

/// Class that verifies if the input entered is actually a valid string.
/// Returns False if the string is NOT valid.
/// Returns True if the string is valid.
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

/// Class that verifies if the input entered is actually a valid email.
/// Returns False if the email is NOT valid.
/// Returns True if the email is valid.
class NonEmptyEmailValidator implements EmailValidator {
  int minimum = 6;

  @override
  bool isValid(String value) {
    if (value.isEmpty ||
        value.length < minimum ||
        value.trim().length < minimum ||
        value.trim().isEmpty ||
        (!RegExp(
                r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value))) {
      return false;
    } else {
      return value.isNotEmpty;
    }
  }
}

/// Checks the name of the child.
/// Returns False if the name is NOT valid.
/// Returns True if the name is valid.
class validNameValidator implements NameValidator {
  @override
  bool isValid(String value) {
    if (value.isEmpty ||
        value.length < 3 ||
        value.trim().isEmpty ||
        value.trim().length < 3) {
      return false;
    } else {
      return value.isNotEmpty;
    }
  }
}

/// Checks the id of the child.
/// Returns False if the id is NOT valid.
/// Returns True if the id is valid.
class validIdValidator implements IdValidator {
  int minimum = 0;
  int parsedID = 0;

  @override
  bool isValid(String id) {
    try {
      parsedID = int.tryParse(id)!;
    } catch (e) {
      debugPrint(
          'validValidator thrown an exception because of input ${id} cant be parsed into a int',
          wrapWidth: 1024);
    }
    if (parsedID < minimum && parsedID < 1000000) {
      return false;
    } else {
      return true;
    }
  }
}

/// Checks the status of the child.
/// Returns False if the status is NOT valid.
/// Returns True if the status is valid.
class validStatusValidator implements StatusValidator {
  @override
  bool isValid(Status status) {
    if (status == Status.START ||
        status == Status.ARRIVED ||
        status == Status.PICKED ||
        status == Status.ABSENT) {
      return true;
    } else {
      return false;
    }
  }
}

class EmailAndPasswordValidators {
  final EmailValidator emailValidator = NonEmptyEmailValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();
  final NameValidator nameValidator = validNameValidator();
  final StatusValidator statusValidator = validStatusValidator();
  final IdValidator idValidator = validIdValidator();

  final String invalidEmailErrorText = 'Email is invalid!';
  final String emptyEmailErrorText = 'Email can\'t be empty';
  final String invalidPasswordErrorText = 'Password is invalid!';
  final String emptyPasswordErrorText = 'Password can\'t be empty';
  final String emptyNameErrorText = 'Name can\'t be empty';
  final String invalidNameErrorText = 'Name is invalid!';
  final String invalidStatusErrorText = 'Status is invalid!';
}

//TODO: REMOVE THE LINES BELOW BEFORE SENDING IN THE EXAM!!!!!!!!!!!
//TODO: CHECK WETHER THE regex used or this is the most stabile one.
// if (value.isEmpty || value.length < 4 || value.trim().isEmpty || (!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
// r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
// r"{0,253}[a-zA-Z0-9])?)*$").hasMatch(value))) {
