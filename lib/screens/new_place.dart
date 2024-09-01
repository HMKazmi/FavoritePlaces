import 'dart:io';

import 'package:fav_places/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewPlace extends StatelessWidget {
  const NewPlace({super.key});

  @override
  Widget build(BuildContext context) {
    File? pickedImage;
    void _pickImage(File image) {
      pickedImage = image;
    }

    String title = "";
    return Scaffold(
        appBar: AppBar(
          title: Text('New Place'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    title = value;
                  },
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                  decoration: const InputDecoration(label: Text("title")),
                  maxLength: 50,
                ),
                const SizedBox(
                  height: 10,
                ),
                ImageInput(
                  onPickImage: _pickImage,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onSecondary,
                    shape: RoundedRectangleBorder(
                      
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop([title, pickedImage]);
                  },
                  label: const Text('Add Place'),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ));
  }
}
