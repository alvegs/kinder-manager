import 'package:flutter/material.dart';

/// Creates content to the bottom model sheet.
class BottomModelContent extends StatelessWidget {
  const BottomModelContent({
    Key? key,
    required this.titleText,
    required this.createForm,
    required this.onChangeImage,
    required this.onDeleteSection,
    required this.onSaveSection, required this.mediaQueryData,
  }) : super(key: key);
  final String titleText;
  final Widget createForm;
  final VoidCallback onChangeImage;
  final VoidCallback onDeleteSection;
  final VoidCallback onSaveSection;
  final MediaQueryData mediaQueryData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: mediaQueryData.viewInsets,
      child: Container(
        height: 200,
        color: Colors.lightGreen[100],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                titleText,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),

              /// Form to give input.
              createForm,
              const SizedBox(
                height: 20,
              ),

              /// Aligning buttons side by side.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                    ),
                    onPressed: onDeleteSection,
                    child: const Text('Delete'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: onChangeImage,
                    child: const Text('image'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: onSaveSection,
                    child: const Text('Save'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
