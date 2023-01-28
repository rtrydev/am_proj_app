import 'package:json_annotation/json_annotation.dart';

part 'waypoint_data.g.dart';

@JsonSerializable()
class WaypointData {
  String id;
  double coordinateX;
  double coordinateY;
  String description;
  String title;

  WaypointData({
    required this.id,
    required this.coordinateX,
    required this.coordinateY,
    required this.description,
    required this.title
  });

  factory WaypointData.fromJson(Map<String, dynamic> json) => _$WaypointDataFromJson(json);
  Map<String, dynamic> toJson() => _$WaypointDataToJson(this);
}