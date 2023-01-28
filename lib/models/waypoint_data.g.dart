// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waypoint_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WaypointData _$WaypointDataFromJson(Map<String, dynamic> json) => WaypointData(
      id: json['id'] as String,
      coordinateX: (json['coordinateX'] as num).toDouble(),
      coordinateY: (json['coordinateY'] as num).toDouble(),
      description: json['description'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$WaypointDataToJson(WaypointData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'coordinateX': instance.coordinateX,
      'coordinateY': instance.coordinateY,
      'description': instance.description,
      'title': instance.title,
    };
