/// Represents a child in kindergarten.
class Child {
  final String name;

  /// Creates a instance of Child class.
  Child({required this.name});

  Map<String, dynamic> toMap() {
    return {
      "name": name,
    };
  }
}
