// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waypoint_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WaypointEvent _$WaypointEventFromJson(Map<String, dynamic> json) =>
    WaypointEvent(
      event_id: json['event_id'] as String,
      timestamp: json['timestamp'] as int,
    );

Map<String, dynamic> _$WaypointEventToJson(WaypointEvent instance) =>
    <String, dynamic>{
      'event_id': instance.event_id,
      'timestamp': instance.timestamp,
    };
