import 'package:am_proj_app/models/question.dart';
import 'package:am_proj_app/models/waypoint_event.dart';
import 'package:am_proj_app/models/waypoint_event_init_data.dart';
import 'package:injectable/injectable.dart';

import '../api/retrofit_api.dart';
import '../api/retrofit_client.dart';
import '../models/waypoint_data.dart';
import 'i_waypoint_event_service.dart';

@Injectable(as: IWaypointEventService)
class WaypointEventService implements IWaypointEventService {
  @override
  Future<WaypointEvent> initialize(String waypointId) async {
    final api = RetrofitApi();
    final dio = await api.getApiClient();
    final client = RestClient(dio);

    final initData = WaypointEventInitData(waypoint_id: waypointId);
    final result = await client.initializeEvent(initData);

    return result;
  }

  @override
  Future<Question> getQuestion(String eventId) async {
    final api = RetrofitApi();
    final dio = await api.getApiClient();
    final client = RestClient(dio);

    final result = await client.getQuestionForEvent(eventId);

    return result;
  }

}