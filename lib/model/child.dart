/// Defining the status of the child.
/// Default status will be START.
/*enum Status {
  START,
  ARRIVED,
  PICKED,
  ABSENT,
}*/

/// Represents a child in kindergarten.
class Child {
  final String name;
  final String id;
  final String status;

  /// Creates a instance of Child class.
  /// name : name of the child
  /// id : document id from the firestore
  /// status : status of the child in kindergarten
  Child({required this.name, required this.id, this.status = "START"});

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "status": status,
    };
  }
}
