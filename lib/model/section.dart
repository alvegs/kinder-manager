import 'package:flutter/material.dart';

/// Represents a section in the kindergarten,
/// with id, name and color.
class Section {
  final int id;
  final String name;
  final Color color;

  /// Creates an instance of Section.
  const Section({
    required this.id,
    required this.name,
    required this.color,
  });
}
