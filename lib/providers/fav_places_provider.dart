import 'dart:io';

import 'package:fav_places/models/fav_place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class FavPlacesNotifier extends StateNotifier<List<FavPlace>> {
  FavPlacesNotifier() : super([]);

  Future<Database> openDatabase() async {
    final dbPath = await sql.getDatabasesPath();

    final db = await sql.openDatabase(
      path.join(dbPath, "places.db"),
      onCreate: (db, version) {
        return db.execute('''
        CREATE TABLE places (
            id TEXT PRIMARY KEY, title TEXT, image TEXT, latitude REAL, longitude REAL, address TEXT
        )
        ''');
      },
      version: 1,
    );
    return db;
  }

  Future<void> loadFavPlaces() async {
    final db = await openDatabase();
    final data = await db.query('places');
    final places = data
        .map((row) => FavPlace(
              id: row['id'] as String,
              title: row['title'] as String,
              image: File(row['image'] as String),
              location: PlaceLocation(
                latitude: row['latitude'] as double,
                longitude: row['longitude'] as double,
                address: row['address'] as String,
              ),
            ))
        .toList();
      print(places);
        state=places;
  }

  void addFavPlace(String title, File image, PlaceLocation location) async {
    final devicePath = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final newPath = await image.copy('${devicePath.path}/$fileName');
    // print(newPath.toString());

    FavPlace newPlace =
        FavPlace(title: title, image: newPath, location: location);
    final db = await openDatabase();
    db.insert(
      'places',
      {
        'id': newPlace.id,
        'title': title,
        'image': newPlace.image.path,
        'latitude': location.latitude,
        'longitude': location.longitude,
        'address': location.address
      },
    );
    db.close();

    state = [newPlace, ...state];
  }

  void removeFavPlace(FavPlace favPlace) {
    state = [...state.where((element) => element.id != favPlace.id)];
  }
}

final favPlacesProvider =
    StateNotifierProvider<FavPlacesNotifier, List<FavPlace>>(
  (ref) => FavPlacesNotifier(),
);
