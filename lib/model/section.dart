import 'package:flutter/material.dart';

/// Represents a section in the kindergarten,

class Section {
  final String id;
  final String name;

  /// Creates an instance of Section.
  const Section({required this.name, required this.id});

  Section fromMap(Map<String, dynamic> data, String docId) {
    return Section(id: docId, name: data["section name"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "section name": name,
    };
  }
}
