import 'package:fav_places/models/fav_place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavPlacesNotifier extends StateNotifier<List<FavPlace>> {
  FavPlacesNotifier() : super([]);
  void addFavPlace(FavPlace favPlace) {
    state = [...state, favPlace];
  }

  void removeFavPlace(FavPlace favPlace) {
    state = [...state.where((element) => element.id != favPlace.id)];
  }
}

final favPlacesProvider =
    StateNotifierProvider<FavPlacesNotifier, List<FavPlace>>(
  (ref) => FavPlacesNotifier(),
);
