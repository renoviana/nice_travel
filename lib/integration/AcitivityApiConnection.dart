import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nice_travel/model/Schedule.dart';

import 'ApiConnection.dart';
import 'json/ActivityJson.dart';

class ActivityApiConnection {

  ActivityApiConnection._();

  /// Provides an instance of this class corresponding to the default app.
  static final ActivityApiConnection instance = new ActivityApiConnection._();

  Future<List<Activity>> getActiviesByScheduleDay(int scheduleDayId) async {
    final url = ApiConnection.URL_API +
        "/activity?scheduleDayId=$scheduleDayId";
    return _formatFutureToActivities(await http.Client().get(url));
  }

  List<Activity> _formatFutureToActivities(Response response) {
    if (response.statusCode == 200) {
      return _formatActivityJson(response.body);
    }
    return [];
  }

  List<Activity> _formatActivityJson(String json) {
    return ActivityJson().parseActivityJsonToActivity(json);
  }

}
