/// Represents a child in kindergarten.
class Child {
  /// The name of the child.
  final String name;

  /// The id of the child.
  final String id;

  /// The image file of the child.
  final String imageFile;

  /// Returns whether the child is counted
  bool isCounted;

  /// Defining the status of the child.
  /// START is default status.
  /// ARRIVED is used to define that the child have arrived at the kindergarten.
  /// PICKED is used to define that the child have been picked up.
  /// ABSENT is used to define that the child is not in the kindergarten.
  String status;

  /// Creates a instance of Child class.
  /// name : name of the child
  /// id : document id from the firestore
  /// status : status of the child in kindergarten
  /// isCounted : count status
  Child({
    required this.name,
    required this.id,
    required this.imageFile,
    this.status = 'START',
    this.isCounted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "status": status,
      "image file": imageFile,
      "isCounted": isCounted,
    };
  }
}
