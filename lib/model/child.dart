import 'package:kindermanager/application/sign_in/validators.dart';

/// Represents a child in kindergarten.
class Child {
  /// The name of the child.
  final String name;

  /// The id of the child.
  final String id;

  /// Defining the status of the child.
  /// START is default status.
  /// ARRIVED is used to define that the child have arrived at the kindergarten.
  /// PICKED is used to define that the child have been picked up.
  /// ABSENT is used to define that the child is not in the kindergarten.
  String status = 'Start';

  /// Creates a instance of Child class.
  /// name : name of the child
  /// id : document id from the firestore
  /// status : status of the child in kindergarten

  Child({
    required this.name,
    required this.id,
    this.status = 'Start',
  })  : assert(ValidNameValidator().isValid(name)),
        assert(ValidIdValidator().isValid(id)),
        assert(ValidStatusValidator().isValid(status));

  /// Returns a map of the child.
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "status": status,
    };
  }
}
