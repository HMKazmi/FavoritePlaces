import 'package:fav_places/models/fav_place.dart';
import 'package:fav_places/screens/new_place.dart';
import 'package:fav_places/providers/fav_places_provider.dart';
import 'package:fav_places/screens/place_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// List<FavPlace> favPlacesScreenList = [
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
    final favPlacesScreenList = ref.watch(favPlacesProvider);
    print(favPlacesScreenList);
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Places"),
        actions: [
          IconButton(
              onPressed: () async {
                final title = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewPlace(),
                  ),
                );
                if (title != "" && !(title==null)) {
                  setState(() {
                    favPlacesScreenList.add(
                      FavPlace(title: title),
                    );
                  });
                }
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
        itemCount: favPlacesScreenList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(favPlacesScreenList[index]),
            onDismissed: (direction) {
              favPlacesScreenList.remove(favPlacesScreenList[index]);
              // _removeItem(favPlacesScreenList[index]);
            },
            child: ListTile(
onTap: (){
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PlaceDetailsScreen(favPlace: favPlacesScreenList[index],),
      ),
      );
},
              // leading: Container(
              //   height: 15,
              //   width: 15,
              //     decoration: BoxDecoration(
              //         color: Colors.lightBlue),
              // ),
              title: Text(
                favPlacesScreenList[index].title,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                    ),
              ),
              // trailing: Text(
              //   favPlacesScreenList[index].id,
              //   style: const TextStyle(fontSize: 16, color: Colors.white),
              // ),
            ),
          );
        },
      ),
    );
  }
}
