import 'package:json_annotation/json_annotation.dart';

part 'waypoint_event_init_data.g.dart';

@JsonSerializable()
class WaypointEventInitData {
  final String waypoint_id;

  WaypointEventInitData({
    required this.waypoint_id
  });

  factory WaypointEventInitData.fromJson(Map<String, dynamic> json) => _$WaypointEventInitDataFromJson(json);
  Map<String, dynamic> toJson() => _$WaypointEventInitDataToJson(this);
}