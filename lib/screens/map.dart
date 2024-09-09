import 'package:fav_places/models/fav_place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  MapScreen(
      {super.key,
      this.location = const PlaceLocation(
        latitude: 37.422,
        longitude: -122.084,
        address: '',
      ),
      this.isSelecting = true});

  final PlaceLocation location;
  bool isSelecting;
  @override
  State<StatefulWidget> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  LatLng? pickedLocation;
  bool isFirst = true;
  @override
  Widget build(BuildContext context) {
    print(widget.location.address);
    if (widget.location.address != '') {
      isFirst = false;
      //   pickedLocation=LatLng(widget.location.latitude, widget.location.longitude) ;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.isSelecting ? 'Select a location' : 'Selected  location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                widget.isSelecting = false;
                Navigator.pop(context, pickedLocation);
              },
            ),
        ],
      ),
      body: GoogleMap(
        onTap: !widget.isSelecting
            ? null
            : (position) {
                setState(() {
                  pickedLocation = position;
                });
              },
        initialCameraPosition: CameraPosition(
          target: pickedLocation ??
              LatLng(
                widget.location.latitude,
                widget.location.longitude,
              ),
          zoom: 16,
        ),
        markers: (pickedLocation == null && widget.isSelecting && isFirst)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId("m1"),
                  position: pickedLocation ??
                      LatLng(
                        widget.location.latitude,
                        widget.location.longitude,
                      ),
                ),
              },
      ),
    );
  }
}
