import '../application/sign_in/validators.dart';

/// Represents a section in the kindergarten,
class Section {
  final String id;
  final String name;
  final String imageFile;

  /// Creates an instance of Section.
  Section({
    /// The name of the section.
    required this.name,

    /// The id of the section.
    required this.id,

    /// The image file of the section
    required this.imageFile,
  })  : assert(ValidNameValidator().isValid(name)),
        assert(ValidIdValidator().isValid(id)),
        assert(ValidImageFileValidator().isValid(imageFile));

  /* Section fromMap(Map<String, dynamic> data, String docId) {
    return Section(
        id: docId, name: data["section name"], imageFile: data["image file"]);
  }*/

  Map<String, dynamic> toMap() {
    return {
      "section name": name,
      "image file": imageFile,
    };
  }
}
