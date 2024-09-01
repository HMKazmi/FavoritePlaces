import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  // File _pickedImage;
  // final _picker = ImagePicker();
  // void _pickImage() async {
  //   final pickedFile = await _picker.getImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _pickedImage = File(pickedFile.path);
  //       });
  //       }
  //       }
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          ),
        ),
        child: TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.camera),
          label: const Text("Add Image"),
        ));
  }
}
