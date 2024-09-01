import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});
  final void Function (File image) onPickImage;
  @override
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _pickedImage;
  // File _pickedImage;
  // void _pickImage() async {
  //   final pickedFile = await _picker.getImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _pickedImage = File(pickedFile.path);
  //       });
  //       }
  //       }
  void _takePicture() async {
    final _picker = ImagePicker();

    final _pickedFile = await _picker.pickImage(
        source: ImageSource.camera); //.then((pickedFile) {},);
    if (_pickedFile == null) {
      return;
    }

    setState(() {
      _pickedImage = File(_pickedFile.path);
    });

    widget.onPickImage(_pickedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
        onPressed: _takePicture,
        icon: const Icon(Icons.camera),
        label: const Text("Add Image"),
      
    );

    if (_pickedImage != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          _pickedImage!,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }

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
        child: content);
  }
}
