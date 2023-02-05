import 'dart:async';

import 'package:am_proj_app/services/i_waypoint_event_service.dart';
import 'package:am_proj_app/services/i_waypoint_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  bool locationEnabled = false;
  LatLng location = const LatLng(49.783393, 19.057861);
  Timer? timer;

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  final IWaypointService waypointService = getIt<IWaypointService>();
  final IWaypointEventService waypointEventService = getIt<IWaypointEventService>();

  checkWaypointProximity() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == "") {
      return;
    }

    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((position) {
          double lat = position.latitude;
          double long = position.longitude;
          print("get position " + (new DateTime.now()).toString());

          Marker? markerToDelete = null;

          for (var marker in markers) {
            final markerId = marker.markerId.value;
            print(markerId);

            var markerWaypoint = waypoints.firstWhere((element) => element.id == markerId,
                orElse: () => WaypointData(id: "", coordinateX: 0, coordinateY: 0, description: "", title: ""));

            if (markerWaypoint.id == "") {
              continue;
            }

            if ((lat - markerWaypoint.coordinateX).abs() < 0.001 && (long - markerWaypoint.coordinateY).abs() < 0.001) {
              print("close to " + markerId);
              markerToDelete = marker;
            }
          }

          if (markerToDelete != null) {
            setState(() {
              markers.remove(markerToDelete);
            });
            print("starting event on " + markerToDelete.markerId.value);

            waypointEventService.initialize(markerToDelete.markerId.value)
              .then((event) {
                print("started event");
                print(event.event_id);

                waypointEventService.getQuestion(event.event_id)
                  .then((question) {
                    print(question.contents);
                  });
              });
          }
    });
  }

  @override
  void initState() {
    super.initState();

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

    waypointService.getWaypoints().then((result) {
      setState(() {
        waypoints = result;
        markers = result.map(
            (waypoint) => Marker(
              markerId: MarkerId(waypoint.id),
              position: LatLng(waypoint.coordinateX, waypoint.coordinateY)
            )
        ).toSet();
      });
    });

    if (timer != null) {
      return;
    }

    timer = Timer.periodic(const Duration(seconds: 3), (Timer t) async => await checkWaypointProximity());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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