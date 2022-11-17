import 'package:kindermanager/application/sign_in/validators.dart';

/// Defining the status of the child.
/// Default status will be START.
/// START is used to define a dummy value to prevent the other statuses to be used if they are not needed.
/// ARRIVED is used to define that the child have arrived at the kindergarten.
/// PICKED is used to define that the child have been picked up by it's parents and are no longer at the kindergarten.
/// ABSENT is used to define that the child is found and are currently at the kindergarten.
enum Status {
  START,
  ARRIVED,
  PICKED,
  ABSENT,
}

/// Represents a child in kindergarten.
class Child {
  final String name;
  final String id;
 // final Status status; TODO: REMOVE THIS COMMENT WHEN STATUS IS WORKING PROPERLY!
  final String status; // TODO: REMOVE THIS LINE WHEN THE STATUS IS WORKING PROPERLY!

  /// Creates a instance of Child class.
  /// name : name of the child
  /// id : document id from the firestore
  /// status : status of the child in kindergarten
  Child({
    required this.name,
    required this.id,
    // this.status = Status.START  TODO: REMOVE THIS COMMENT WHEN STATUS IS WORKING PROPERLY!
    this.status = 'Start' // TODO: REMOVE THIS LINE WHEN THE STATUS IS WORKING PROPERLY!
  }) : assert(validNameValidator().isValid(name)),
        assert(validIdValidator().isValid(id))
       // assert(validStatusValidator().isValid(status)) TODO: REMOVE COMMENT WHEN THIS ACTUALLY WORKS
  ;


 /// Returns a map of the child.
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "status": status,
    };
  }
}
