import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nice_travel/model/Schedule.dart';

import 'ApiConnection.dart';
import 'json/ActivityJson.dart';

class ActivityApiConnection {
  ActivityApiConnection._() {
    print('Calling ActivityApiConnection');
  }

  static final ActivityApiConnection instance = new ActivityApiConnection._();

  Future<List<Activity>> getActiviesByScheduleDay(int scheduleDayId) async {
    final url =
        ApiConnection.URL_API + "/activity?scheduleDayId=$scheduleDayId";
    return _formatFutureToActivities(await http.get(url));
  }

  Future<Activity> addActivity(Activity activity) async {
    final url = ApiConnection.URL_API +
        "/activity/add?"
            "description=${activity.description}"
            "&nameOfPlace=${activity.nameOfPlace}"
            "&price=${activity.price}"
            "&startActivity=${activity.startActivityDate}"
            "${activity.finishActivityDate != null ? "&finishActivity=${activity.finishActivityDate}" : ""}"
            "&styleActivity=${activity.styleActivity}"
            "&idScheduleDay=${activity.idScheduleDay}"
            "${activity.id != null ? "&id=${activity.id}" : ""}";
    return _formatFutureToActivity(
        await http.post(ApiConnection.encodeFull(url)));
  }

  Future<Response> deleteActivity(int activityId) async {
    final url =
        ApiConnection.URL_API + "/activity/delete?activityId=$activityId";
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
    } else {
      print('${response.statusCode} - ${response.body}');
    }
    return null;
  }

  Activity _formatActivityJson(String json) {
    return ActivityJson().parseActivityJsonToActivity(json);
  }
}
