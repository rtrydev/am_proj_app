import 'package:json_annotation/json_annotation.dart';

part 'waypoint_event_data.g.dart';

@JsonSerializable()
class WaypointEventData {
  String id;
  String waypoint_id;
  int state;
  bool? answer_correct;

  WaypointEventData({
    required this.id,
    required this.waypoint_id,
    required this.state,
    required this.answer_correct
  });

  factory WaypointEventData.fromJson(Map<String, dynamic> json) => _$WaypointEventDataFromJson(json);
  Map<String, dynamic> toJson() => _$WaypointEventDataToJson(this);
}