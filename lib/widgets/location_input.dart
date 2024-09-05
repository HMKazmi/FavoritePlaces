import 'dart:convert';

import 'package:fav_places/models/fav_place.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectLocation});
  final void Function(PlaceLocation selectedLocation) onSelectLocation;
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  bool _isGettingLocation = false;
  PlaceLocation? _selectedLocation;

  String apiKey = "AIzaSyBiBwNfeSmoUasQ4_hsNsiPebFi8ewz8sE";

  // String apiKey = "AIzaSyB_tvw6vcmp9QomP4RsHUGwqV0O7BeFTkg"; //pl mam wala

  String get locationImage {
    if (_selectedLocation == null) {
      return '';
    }
    // return "https://maps.googleapis.com/maps/api/staticmap?center=Berkeley,CA&zoom=14&size=400x400&key=$apiKey";
    return "https://maps.googleapis.com/maps/api/staticmap?center=${_selectedLocation!.latitude},${_selectedLocation!.longitude}&zoom=17&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C${_selectedLocation!.latitude},${_selectedLocation!.longitude}&key=$apiKey";
  }


  void getLocation() async {
    setState(() {
      _isGettingLocation = true;
    });
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    var longitude = _locationData.longitude;
    var latitude = _locationData.latitude;

    var url = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey");
    var mapJsonData = await http.get(url);
    if (mapJsonData == null) {
      return;
    }
    var mapData = json.decode(mapJsonData.body);
    print(mapData);
    var address = mapData['results'][0]["formatted_address"];
    if (latitude == null || longitude == null) {
      return;
    }
    setState(() {
      _isGettingLocation = false;
      _selectedLocation = PlaceLocation(
          address: address, latitude: latitude, longitude: longitude);
    });
    widget.onSelectLocation(_selectedLocation!);
  }

  @override
  Widget build(context) {
    Widget perviewContent = Text(
      "No location Selected",
      style: TextStyle(color: Theme.of(context).colorScheme.primary),
    );
    if (_isGettingLocation) {
      perviewContent = CircularProgressIndicator();
    }
    if (_selectedLocation != null) {
      perviewContent = Image.network(locationImage,
          fit: BoxFit.cover, height: double.infinity, width: double.infinity);
    }
    return Column(
      children: [
        Container(
            height: 170,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              ),
            ),
            child: perviewContent),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: getLocation,
              icon: const Icon(Icons.location_on),
              label: const Text("Get Current Location"),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: const Text("Select on Map"),
            ),
          ],
        )
      ],
    );
  }
}
