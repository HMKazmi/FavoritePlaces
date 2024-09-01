import 'package:fav_places/models/fav_place.dart';
import 'package:fav_places/screens/new_place.dart';
import 'package:fav_places/providers/fav_places_provider.dart';
import 'package:fav_places/screens/place_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// List<FavPlace> favPlacesList = [
//   FavPlace(title: "Place Title 1"),
//   FavPlace(title: "Place Title 2")
// ];

class FavPlacesScreen extends ConsumerStatefulWidget {
  const FavPlacesScreen({super.key});
  @override
  ConsumerState<FavPlacesScreen> createState() => _FavPlacesScreenState();
}

class _FavPlacesScreenState extends ConsumerState<FavPlacesScreen> {
  @override
  Widget build(BuildContext context) {
    final favPlacesList = ref.watch(favPlacesProvider);
    print(favPlacesList);
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Places"),
        actions: [
          IconButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewPlace(),
                  ),
                );
                if (result != ["", null] && result != [null, null]) {
                  setState(() {
                    favPlacesList.add(
                      FavPlace(title: result[0], image: result[1]),
                    );
                  });
                }
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView.builder(
          itemCount: favPlacesList.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: ValueKey(favPlacesList[index]),
              onDismissed: (direction) {
                favPlacesList.remove(favPlacesList[index]);
                // _removeItem(favPlacesList[index]);
              },
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaceDetailsScreen(
                        favPlace: favPlacesList[index],
                      ),
                    ),
                  );
                },
                leading: Container(
                  height: 30,
                  width: 30,
                  child: CircleAvatar(
                    backgroundImage: FileImage(favPlacesList[index].image),
                  ),
                ),
                title: Text(
                  favPlacesList[index].title,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                      ),
                ),
                // trailing: Text(
                //   favPlacesList[index].id,
                //   style: const TextStyle(fontSize: 16, color: Colors.white),
                // ),
              ),
            );
          },
        ),
      ),
    );
  }
}
