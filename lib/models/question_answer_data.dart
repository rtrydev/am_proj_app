import 'package:json_annotation/json_annotation.dart';

part 'question_answer_data.g.dart';

@JsonSerializable()
class QuestionAnswerData {
  String question_id;
  String answer_id;
  String event_id;

  QuestionAnswerData({
    required this.question_id,
    required this.answer_id,
    required this.event_id
  });

  factory QuestionAnswerData.fromJson(Map<String, dynamic> json) => _$QuestionAnswerDataFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionAnswerDataToJson(this);
}