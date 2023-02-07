import 'package:am_proj_app/models/waypoint_data.dart';
import 'package:am_proj_app/services/i_waypoint_service.dart';
import 'package:injectable/injectable.dart';

import '../api/retrofit_api.dart';
import '../api/retrofit_client.dart';

@Injectable(as: IWaypointService)
class WaypointService implements IWaypointService {
  @override
  Future<List<WaypointData>> getWaypoints() async {
    final api = RetrofitApi();
    final dio = await api.getApiClient();
    final client = RestClient(dio);

    final waypoints = await client.getWaypoints();

    return waypoints;
  }

  @override
  Future<WaypointData> getWaypointById(String id) async {
    final api = RetrofitApi();
    final dio = await api.getApiClient();
    final client = RestClient(dio);

    final waypoints = await client.getWaypointById(id);

    return waypoints;
  }

}