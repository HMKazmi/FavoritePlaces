import 'dart:io';

import 'package:uuid/uuid.dart';

class PlaceLocation {
  const PlaceLocation(
      {required this.latitude, required this.longitude, required this.address});
  final double latitude;
  final double longitude;
  final String address;
}

class FavPlace {
  FavPlace({required this.title, required this.image, required this.location})
      : id = const Uuid().v4();

  final String id;
  final String title;
  final File image;
  final PlaceLocation location;
}
