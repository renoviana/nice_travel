import 'package:nice_travel/model/Acitivty.dart';

import 'ApiConnectionHelper.dart';
import 'json/ActivityJson.dart';

class ActivityApiConnection {
  ActivityApiConnection._();

  static final ActivityApiConnection instance = new ActivityApiConnection._();

  Future<List<Activity>> getActiviesByScheduleDay(int scheduleDayId) async {
    final url =
        ApiConnectionHelper.URL_API + "/activity?scheduleDayId=$scheduleDayId";
    return _formatFutureToActivities(await ApiConnectionHelper.get(url));
  }

  Future<Activity> addActivity(Activity activity) async {
    final url = ApiConnectionHelper.URL_API +
        "/activity/add?"
            "description=${activity.description}"
            "&nameOfPlace=${activity.nameOfPlace}"
            "&price=${activity.price}"
            "&startActivity=${activity.startActivityDate}"
            "${activity.finishActivityDate != null ? "&finishActivity=${activity.finishActivityDate}" : ""}"
            "&styleActivity=${activity.styleActivity}"
            "&idScheduleDay=${activity.idScheduleDay}"
            "${activity.id != null ? "&id=${activity.id}" : ""}";
    return _formatFutureToActivity(await ApiConnectionHelper.post(url));
  }

  Future<dynamic> deleteActivity(int activityId) async {
    final url =
        ApiConnectionHelper.URL_API + "/activity/delete?activityId=$activityId";
    return await ApiConnectionHelper.delete(url);
  }

  List<Activity> _formatFutureToActivities(String response) {
    return _formatActivitiesJson(response);
  }

  List<Activity> _formatActivitiesJson(String json) {
    return ActivityJson().parseActivityJsonToActivities(json);
  }

  Activity _formatFutureToActivity(String response) {
    return _formatActivityJson(response);
  }

  Activity _formatActivityJson(String json) {
    return ActivityJson().parseActivityJsonToActivity(json);
  }
}
