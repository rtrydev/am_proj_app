// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waypoint_event_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WaypointEventData _$WaypointEventDataFromJson(Map<String, dynamic> json) =>
    WaypointEventData(
      id: json['id'] as String,
      waypoint_id: json['waypoint_id'] as String,
      state: json['state'] as int,
      answer_correct: json['answer_correct'] as bool?,
    );

Map<String, dynamic> _$WaypointEventDataToJson(WaypointEventData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'waypoint_id': instance.waypoint_id,
      'state': instance.state,
      'answer_correct': instance.answer_correct,
    };
