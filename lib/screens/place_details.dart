import 'package:fav_places/models/fav_place.dart';
import 'package:fav_places/screens/map.dart';
import 'package:flutter/material.dart';

class PlaceDetailsScreen extends StatelessWidget {
  PlaceDetailsScreen({required FavPlace this.favPlace, super.key});
  final FavPlace favPlace;

  String get locationImage {
    String apiKey = "AIzaSyBiBwNfeSmoUasQ4_hsNsiPebFi8ewz8sE";

    return "https://maps.googleapis.com/maps/api/staticmap?center=${favPlace.location.latitude},${favPlace.location.longitude}&zoom=17&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C${favPlace.location.latitude},${favPlace.location.longitude}&key=$apiKey";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(favPlace.title),
      ),
      body: Stack(
        children: [
          Image.file(
            favPlace.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return MapScreen(location: favPlace.location, isSelecting: false,);
                          },
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(
                        locationImage,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black54],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                    child: Text(
                      favPlace.location.address,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // Center(
      //   child: Column(
      //     children: [
      //       // Text(
      //       //   favPlace.title,
      //       //   style: Theme.of(context).textTheme.bodyLarge!.copyWith(
      //       //         color: Colors.white,
      //       //       ),
      //       // ),
      //     ],
      //   ),
      // ),
    );
  }
}
