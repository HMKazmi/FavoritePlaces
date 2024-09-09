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
  late Future<void> _placesFuture;
  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(favPlacesProvider.notifier).loadFavPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final favPlaces = ref.watch(favPlacesProvider.notifier);
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
                if (result != null &&
                    result != ["", null] &&
                    result != [null, null]) {
                  setState(() {
                    favPlaces.addFavPlace(result[0], result[1], result[2]);
                  });
                }
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: _placesFuture,
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(5.0),
                child: favPlacesList.length == 0
                    ?  Center(
                        child: Text(
                            "No Places Added Yet.\nClick + button int top right to add one.",
                            style: Theme.of(context).textTheme.titleMedium!,),
                      )
                    : ListView.builder(
                        itemCount: favPlacesList.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: ValueKey(favPlacesList[index]),
                            onDismissed: (direction) {
                              favPlacesList.remove(favPlacesList[index]);
                              // Have to Improve it
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
                                  backgroundImage:
                                      FileImage(favPlacesList[index].image),
                                ),
                              ),
                              title: Text(
                                favPlacesList[index].title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Theme.of(context).colorScheme.onSurface,
                                    ),
                              ),
                              subtitle: Text(
                                favPlacesList[index].location.address,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: Theme.of(context).colorScheme.onSurface,                                    ),
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
      ),
    );
  }
}
