import 'dart:async';

import 'package:am_proj_app/services/i_waypoint_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../dependency_injection.dart';
import '../models/waypoint_data.dart';

class GameMap extends StatefulWidget {
  const GameMap({Key? key}) : super(key: key);

  @override
  State<GameMap> createState() => GameMapState();
}

class GameMapState extends State<GameMap> {
  Set<Marker> markers = {};
  bool locationEnabled = false;
  LatLng location = const LatLng(49.783393, 19.057861);

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  final IWaypointService waypointService = getIt<IWaypointService>();

  @override
  Widget build(BuildContext context) {
    [
      Permission.locationWhenInUse
    ].request().then(
        (result) {
          if (result.isNotEmpty) {
            Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
              .then((position) {
                double lat = position.latitude;
                double long = position.longitude;

                setState(() {
                  locationEnabled = true;
                  location = LatLng(lat, long);
                });
            });
          }
        }
    );

    waypointService.getWaypoints()
      .then((result) {
        setState(() {
          markers = result.map(
                  (waypoint) =>
                  Marker(
                      markerId: MarkerId(waypoint.id),
                      position: LatLng(waypoint.coordinateX, waypoint.coordinateY)
                  )
          ).toSet();
        });
      });

    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: location,
          zoom: 14
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers,
        myLocationEnabled: locationEnabled
      )
    );
  }

}