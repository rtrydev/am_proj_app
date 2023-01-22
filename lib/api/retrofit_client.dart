import 'package:dio/dio.dart';
import 'package:am_proj_app/models/login_data.dart';
import 'package:am_proj_app/models/login_result.dart';
import 'package:retrofit/retrofit.dart';

part 'retrofit_client.g.dart';

@RestApi(baseUrl: 'http://127.0.0.1/')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("/users/login")
  Future<LoginResult> loginUser(@Body() LoginData loginData);
}