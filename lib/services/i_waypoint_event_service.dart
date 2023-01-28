import 'package:am_proj_app/models/waypoint_event.dart';

import '../models/question.dart';

abstract class IWaypointEventService {
  Future<WaypointEvent> initialize(String waypointId);
  Future<Question> getQuestion(String eventId);
}