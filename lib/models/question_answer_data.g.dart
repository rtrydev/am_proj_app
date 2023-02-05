// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_answer_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionAnswerData _$QuestionAnswerDataFromJson(Map<String, dynamic> json) =>
    QuestionAnswerData(
      question_id: json['question_id'] as String,
      answer_id: json['answer_id'] as String,
      event_id: json['event_id'] as String,
    );

Map<String, dynamic> _$QuestionAnswerDataToJson(QuestionAnswerData instance) =>
    <String, dynamic>{
      'question_id': instance.question_id,
      'answer_id': instance.answer_id,
      'event_id': instance.event_id,
    };
