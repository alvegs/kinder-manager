import 'package:flutter/material.dart';

/// Represents a section in the kindergarten,
/// with id, name, color and children.
class Section {
  final int id;
  final String name;
  final Color color;
  final List<Child> children;

  /// Creates an instance of Section.
  const Section(this.children, {
    required this.id,
    required this.name,
    required this.color,
  });
}

class Child {
}
