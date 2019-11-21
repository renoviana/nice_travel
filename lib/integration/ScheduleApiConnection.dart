import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nice_travel/integration/ApiConnection.dart';
import 'package:nice_travel/integration/json/ScheduleJson.dart';
import 'package:nice_travel/model/Schedule.dart';

class ScheduleApiConnection {

  ScheduleApiConnection._();

  /// Provides an instance of this class corresponding to the default app.
  static final ScheduleApiConnection instance = new ScheduleApiConnection._();

  Future<List<Schedule>> getScheduleByCityName(String cityName,
      {int sizeElements = 5}) async {
    final url = ApiConnection.URL_API +
        "/schedule/city?cityName=$cityName&sizeElements=$sizeElements";
    return _formatFutureToSchedules(await http.Client().get(url));
  }

  Future<Response> publishSchedule(int codSchedule) {
    final url = ApiConnection.URL_API + "/schedule/publish?scheduleId=$codSchedule";
    return http.post(url);
  }

  Future<Response> createSchedule(String placeId, int numberDays) {
    final url = ApiConnection.URL_API + "/schedule?placeID=$placeId&numberDays=$numberDays";
    return http.post(url);
  }
  List<Schedule> _formatFutureToSchedules(Response response) {
    if (response.statusCode == 200) {
      return _formatScheduleJson(response.body);
    }
    return [];
  }

  List<Schedule> _formatScheduleJson(String json) {
    return ScheduleJson().parseScheduleJsonToSchedule(json);
  }

}
