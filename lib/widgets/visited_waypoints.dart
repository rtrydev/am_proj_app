import 'package:am_proj_app/dependency_injection.dart';
import 'package:am_proj_app/services/i_waypoint_event_service.dart';
import 'package:am_proj_app/services/i_waypoint_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VisitedWaypoints extends StatefulWidget {
  const VisitedWaypoints({Key? key}) : super(key: key);

  @override
  State<VisitedWaypoints> createState() => VisitedWaypointsState();

}

class VisitedWaypointsState extends State<VisitedWaypoints> {
  final waypointEventService = getIt<IWaypointEventService>();
  final waypointService = getIt<IWaypointService>();

  late Future<List<WaypointEventAnswer>> waypointData;

  @override
  void initState() {
    super.initState();

    waypointData = getWaypointData();
  }

  Future<List<WaypointEventAnswer>> getWaypointData() async {
    final events = await waypointEventService.getEventsForUser();
    final List<WaypointEventAnswer> waypointData = [];

    for (var event in events) {
      final waypoint = await waypointService.getWaypointById(event.waypoint_id);
      waypointData.add(WaypointEventAnswer(
          waypointName: waypoint.title,
          answerCorrect: event.answer_correct ?? false)
      );
    }

    return waypointData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<WaypointEventAnswer>>(
        future: waypointData,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(snapshot.data?[index].waypointName ?? ""),
                        const SizedBox(width: 20, height: 20,),
                        Text((snapshot.data?[index].answerCorrect ?? false) ? "Poprawna odpowiedz" : "Niepoprawna odpowiedz")
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(),
                itemCount: snapshot.data?.length ?? 0);
          } else {
            return const Text("no data");
          }
        }),
      );
  }
}

class WaypointEventAnswer {
  final String waypointName;
  final bool answerCorrect;

  WaypointEventAnswer({
    required this.waypointName,
    required this.answerCorrect
  });
}