import 'package:am_proj_app/models/question_answer_data.dart';

abstract class IQuestionAnswerService {
  Future<void> answerQuestion({required QuestionAnswerData questionAnswerData});
}