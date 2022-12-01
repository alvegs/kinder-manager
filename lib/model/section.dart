import '../application/sign_in/validators.dart';

/// Represents a section in the kindergarten,
class Section {
  /// The id of the section.
  final String id;

  /// The name of the section.
  final String name;

  /// The image file of the section
  final String imageFile;

  /// Creates an instance of Section.
  Section({
    required this.name,
    required this.id,
    required this.imageFile,
  });

  /*: assert(ValidNameValidator().isValid(name)),
        assert(ValidImageFileValidator().isValid(imageFile));*/
  //assert(ValidIdValidator().isValid(id)),

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
