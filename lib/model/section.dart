/// Represents a section in the kindergarten,

class Section {
  final String id;
  final String name;
  final String imageFile;

  /// Creates an instance of Section.
  const Section({
    required this.name,
    required this.id,
    required this.imageFile,
  });

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
