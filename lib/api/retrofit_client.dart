import 'package:am_proj_app/models/question_answer_data.dart';
import 'package:am_proj_app/models/user_data.dart';
import 'package:am_proj_app/models/waypoint_data.dart';
import 'package:am_proj_app/models/waypoint_event_init_data.dart';
import 'package:dio/dio.dart';
import 'package:am_proj_app/models/login_data.dart';
import 'package:am_proj_app/models/login_result.dart';
import 'package:retrofit/retrofit.dart';

import '../models/question.dart';
import '../models/waypoint_event.dart';
import '../models/waypoint_event_data.dart';

part 'retrofit_client.g.dart';

@RestApi(baseUrl: 'http://127.0.0.1/')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("/users/login")
  Future<LoginResult> loginUser(@Body() LoginData loginData);
  @GET("/users")
  Future<UserData> getUser();

  @GET("/waypoints")
  Future<List<WaypointData>> getWaypoints();
  @GET("/waypoints/{waypointId}")
  Future<WaypointData> getWaypointById(@Path() String waypointId);

  @POST("/waypoint_events/")
  Future<WaypointEvent> initializeEvent(@Body() WaypointEventInitData initData);
  @GET("/waypoint_events/{eventId}/question")
  Future<Question> getQuestionForEvent(@Path() String eventId);
  @GET("/waypoint_events")
  Future<List<WaypointEventData>> getEventsForUser();

  @POST("/question_answers/")
  Future answerQuestion(@Body() QuestionAnswerData questionAnswerData);
}