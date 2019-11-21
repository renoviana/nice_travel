import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nice_travel/model/Schedule.dart';

import 'ApiConnection.dart';
import 'json/ActivityJson.dart';

class ActivityApiConnection {

  ActivityApiConnection._();

  static final ActivityApiConnection instance = new ActivityApiConnection._();

  Future<List<Activity>> getActiviesByScheduleDay(int scheduleDayId) async {
    final url = ApiConnection.URL_API +
        "/activity?scheduleDayId=$scheduleDayId";
    return _formatFutureToActivities(await http.Client().get(url));
  }

  Future<Activity> addActivity(int codSchedule) async {
    final url = ApiConnection.URL_API + "/scheduleDay/add?scheduleId=$codSchedule";
    return _formatFutureToActivity(await http.post(url));
  }

  Future<Response> deleteActivity(int scheduleDayId) async {
    final url = ApiConnection.URL_API + "/scheduleDay/delete?scheduleDayId=$scheduleDayId";
    return await http.delete(url);
  }

  List<Activity> _formatFutureToActivities(Response response) {
    if (response.statusCode == 200) {
      return _formatActivitiesJson(response.body);
    }
    return [];
  }

  List<Activity> _formatActivitiesJson(String json) {
    return ActivityJson().parseActivityJsonToActivities(json);
  }

  Activity _formatFutureToActivity(Response response) {
    if (response.statusCode == 200) {
      return _formatActivityJson(response.body);
    }
    return null;
  }

  Activity _formatActivityJson(String json) {
    return ActivityJson().parseActivityJsonToActivity(json);
  }

}
