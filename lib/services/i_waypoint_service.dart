import 'package:am_proj_app/models/waypoint_data.dart';

abstract class IWaypointService {
  Future<List<WaypointData>> getWaypoints();
  Future<WaypointData> getWaypointById(String id);
}