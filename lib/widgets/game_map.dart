import 'dart:async';

import 'package:am_proj_app/services/i_waypoint_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../dependency_injection.dart';
import '../models/waypoint_data.dart';

class GameMap extends StatefulWidget {
  const GameMap({Key? key}) : super(key: key);

  @override
  State<GameMap> createState() => GameMapState();
}

class GameMapState extends State<GameMap> {
  List<WaypointData> waypoints = [];
  Set<Marker> markers = {};

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  final IWaypointService waypointService = getIt<IWaypointService>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(49.783393, 19.057861),
    zoom: 15.5,
  );

  @override
  Widget build(BuildContext context) {
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
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers,
      )
    );
  }

}