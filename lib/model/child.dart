/// Represents a child in kindergarten.
class Child {
  final String name;
  final String id;

  /// Creates a instance of Child class.
  /// name : name of the child
  /// id : document id from the firestore
  Child({required this.name, required this.id});

  Map<String, dynamic> toMap() {
    return {
      "name": name,
    };
  }
}
