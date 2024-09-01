import 'dart:io';

import 'package:uuid/uuid.dart';

class FavPlace {
  FavPlace({required this.title, required this.image}) : id = const Uuid().v4();

  final String id;
  final String title;
  final File image;
}
