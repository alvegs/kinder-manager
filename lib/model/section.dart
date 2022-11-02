import 'package:flutter/material.dart';

/// Represents a section in the kindergarten,

class Section {
  final String? id;
  final String name;

  /// Creates an instance of Section.
  const Section({
    required this.name,
    this.id
  });

  Map<String, dynamic> toMap() {
    return {
      "section name": name,
    };
  }
}
