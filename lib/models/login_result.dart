import 'package:json_annotation/json_annotation.dart';

part 'login_result.g.dart';

@JsonSerializable()
class LoginResult {
  final String auth_token;

  LoginResult({
    required this.auth_token
  });

  factory LoginResult.fromJson(Map<String, dynamic> json) => _$LoginResultFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResultToJson(this);
}