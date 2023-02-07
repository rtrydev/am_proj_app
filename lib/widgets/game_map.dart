import 'dart:async';

import 'package:am_proj_app/models/question_answer_data.dart';
import 'package:am_proj_app/services/i_question_answer_service.dart';
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
  final IQuestionAnswerService questionAnswerService = getIt<IQuestionAnswerService>();

  answerQuestion(String questionId, String answerId, String eventId) async {
    final questionAnswerData = QuestionAnswerData(question_id: questionId, answer_id: answerId, event_id: eventId);
    await questionAnswerService.answerQuestion(questionAnswerData: questionAnswerData);
  }

  checkWaypointProximity() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == "") {
      return;
    }

    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((position) {
          double lat = position.latitude;
          double long = position.longitude;

          Marker? markerToDelete = null;

          for (var marker in markers) {
            final markerId = marker.markerId.value;

            var markerWaypoint = waypoints.firstWhere((element) => element.id == markerId,
                orElse: () => WaypointData(id: "", coordinateX: 0, coordinateY: 0, description: "", title: ""));

            if (markerWaypoint.id == "") {
              continue;
            }

            if ((lat - markerWaypoint.coordinateX).abs() < 0.001 && (long - markerWaypoint.coordinateY).abs() < 0.001) {
              markerToDelete = marker;
            }
          }

          if (markerToDelete != null) {
            setState(() {
              markers.remove(markerToDelete);
            });

            waypointEventService.initialize(markerToDelete.markerId.value)
              .then((event) {
                waypointEventService.getQuestion(event.event_id)
                  .then((question) {
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        content: Container(
                          height: 250,
                          child: Column(
                            children: [
                              Text(question.contents, style: const TextStyle(fontSize: 18),),
                              const SizedBox(height: 50),
                              TextButton(
                                  style: TextButton.styleFrom(backgroundColor: Colors.grey),
                                  onPressed: () async {
                                    await answerQuestion(question.id, question.answers[0]["id"], event.event_id);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(question.answers[0]["text"], style: const TextStyle(color: Colors.white),)
                              ),
                              TextButton(
                                  style: TextButton.styleFrom(backgroundColor: Colors.grey),
                                  onPressed: () async {
                                    await answerQuestion(question.id, question.answers[1]["id"], event.event_id);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(question.answers[1]["text"], style: const TextStyle(color: Colors.white))
                              ),
                              TextButton(
                                  style: TextButton.styleFrom(backgroundColor: Colors.grey),
                                  onPressed: () async {
                                    await answerQuestion(question.id, question.answers[2]["id"], event.event_id);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(question.answers[2]["text"], style: const TextStyle(color: Colors.white))
                              ),
                            ],
                          ),
                        ),
                      );
                    });
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
      waypointEventService.getEventsForUser().then((events) {
        final filteredWaypoints = result.where((element) => !events.any((event) => event.waypoint_id == element.id));

        setState(() {
          waypoints = filteredWaypoints.toList();
          markers = filteredWaypoints.map(
                  (waypoint) => Marker(
                  markerId: MarkerId(waypoint.id),
                  position: LatLng(waypoint.coordinateX, waypoint.coordinateY)
              )
          ).toSet();
        });
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