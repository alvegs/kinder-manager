import 'package:flutter/cupertino.dart';

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
  bool isValid(String value);
}

/// Abstract class that shall act like the skeleton for a validator class for imagefile inputs.
abstract class ImageFileValidator {
  bool isValid(String value);
}

/// Class that verifies if the input entered is actually a valid string.
/// Returns False if the string is NOT valid.
/// Returns True if the string is valid.
class ValidStringValidator implements StringValidator {
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
class ValidEmailValidator implements EmailValidator {
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
class ValidNameValidator implements NameValidator {
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
class ValidIdValidator implements IdValidator {
  int minimum = 1; // The lowest id possible to set.
  int maximum = 100000; // The highest id possible to set.

  @override
  bool isValid(String id) {
    bool result = false; // Holds the result of the parsing.
    int parsedID =
        0; // If the string id can be parsed into int, this var will hold the int value.

    // Checks that the string aint empty, too short or too long.
    if (id.trim().isNotEmpty &&
        id.trim().length >= minimum &&
        id.trim().length <= maximum) {
      try {
        // Trying to parse the string into a int. If this is successfull, the string is actually an int.
        parsedID = int.tryParse(id.trim())!;
      } catch (e) {
        // id can be date, and if date is passed it will throw exception
        return true;
        // Exception gets caught if an exception gets thrown due to the string cant be parsed.
     //   debugPrint(
       //     'validValidator thrown an exception because of input ${id} cant be parsed into a int',
        //    wrapWidth: 1024);
      }
    } else {
      // The string input is empty, or is either too short or too long. This is NOT a valid int.
      return false;
    }

    // Checks if the parsedID is actually changed and are actually valid.
    if (parsedID >= minimum && parsedID <= maximum) {
      result = true;
    }

    // Returns the result.
    return result;
  }
}


/// Checks the status of the child.
/// Returns False if the status is NOT valid.
/// Returns True if the status is valid.
class ValidStatusValidator implements StatusValidator {
  @override
  bool isValid(String status) {
    if (status == 'Start' ||
        status == 'Arrived' ||
        status == 'Picked' ||
        status == 'Absent') {
      return true;
    } else {
      // The status recieved is not one of the supported ones.
      return false;
    }
  }
}

/// Class that verifies if the input entered is actually a valid imagefile string.
/// Returns False if the string is NOT valid.
/// Returns True if the string is valid.
class ValidImageFileValidator implements ImageFileValidator {
  /// The minimum length of a image file.
  int minimum = 16;

  /// The maximum length of a image file.
  int maximum = 1000000;

  @override
  bool isValid(String value) {
    if (value.isEmpty ||
        value.trim().isEmpty ||
        value.trim().length < minimum ||
        value.trim().length > maximum) {
      return false;
    } else {
      return value.isNotEmpty;
    }
  }
}

class EmailAndPasswordValidators {
  final EmailValidator emailValidator = ValidEmailValidator();
  final StringValidator passwordValidator = ValidStringValidator();
  final NameValidator nameValidator = ValidNameValidator();
  final StatusValidator statusValidator = ValidStatusValidator();
  final IdValidator idValidator = ValidIdValidator();
  final ImageFileValidator imageFileValidator = ValidImageFileValidator();

  final String invalidEmailErrorText = 'Email is invalid!';
  final String emptyEmailErrorText = 'Email can\'t be empty';
  final String invalidPasswordErrorText = 'Password is invalid!';
  final String emptyPasswordErrorText = 'Password can\'t be empty';
  final String emptyNameErrorText = 'Name can\'t be empty';
  final String invalidNameErrorText = 'Name is invalid!';
  final String invalidStatusErrorText = 'Status is invalid!';
  final String invalidImageFileErrorText = 'ImageFile is invalid!';
}

//TODO: REMOVE THE LINES BELOW BEFORE SENDING IN THE EXAM!!!!!!!!!!!
//TODO: CHECK WETHER THE regex used or this is the most stabile one.
// if (value.isEmpty || value.length < 4 || value.trim().isEmpty || (!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
// r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
// r"{0,253}[a-zA-Z0-9])?)*$").hasMatch(value))) {
