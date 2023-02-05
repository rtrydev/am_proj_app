import 'package:am_proj_app/models/question_answer_data.dart';
import 'package:am_proj_app/services/i_question_answer_service.dart';
import 'package:injectable/injectable.dart';

import '../api/retrofit_api.dart';
import '../api/retrofit_client.dart';

@Injectable(as: IQuestionAnswerService)
class QuestionAnswerService implements IQuestionAnswerService {
  @override
  Future<void> answerQuestion({required QuestionAnswerData questionAnswerData}) async {
    final api = RetrofitApi();
    final dio = await api.getApiClient();
    final client = RestClient(dio);

    await client.answerQuestion(questionAnswerData);
  }
}