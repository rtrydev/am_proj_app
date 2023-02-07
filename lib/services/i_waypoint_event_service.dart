import 'package:am_proj_app/models/waypoint_event.dart';
import 'package:am_proj_app/models/waypoint_event_data.dart';

import '../models/question.dart';

abstract class IWaypointEventService {
  Future<WaypointEvent> initialize(String waypointId);
  Future<Question> getQuestion(String eventId);
  Future<List<WaypointEventData>> getEventsForUser();
}