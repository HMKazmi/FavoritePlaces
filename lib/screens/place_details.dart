import 'package:fav_places/models/fav_place.dart';
import 'package:flutter/material.dart';

class PlaceDetailsScreen extends StatelessWidget {
  PlaceDetailsScreen({required FavPlace this.favPlace, super.key});
  final FavPlace favPlace;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(favPlace.title),
      ),
      body: Stack(children: [
            Image.file(
                favPlace.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,

              ),
            

      ],), 
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
