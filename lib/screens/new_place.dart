import 'package:fav_places/image_input.dart';
import 'package:flutter/material.dart';

class NewPlace extends StatelessWidget {
  const NewPlace({super.key});

  @override
  Widget build(BuildContext context) {
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
                const SizedBox(height: 10,),
                ImageInput(),
                const SizedBox(height: 16,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(title);
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Add Place'),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.add),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
