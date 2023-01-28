import 'package:json_annotation/json_annotation.dart';

part 'waypoint_event.g.dart';

@JsonSerializable()
class WaypointEvent {
  final String event_id;
  final int timestamp;

  WaypointEvent({
    required this.event_id,
    required this.timestamp
  });

  factory WaypointEvent.fromJson(Map<String, dynamic> json) => _$WaypointEventFromJson(json);
  Map<String, dynamic> toJson() => _$WaypointEventToJson(this);
}