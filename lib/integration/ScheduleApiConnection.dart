import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nice_travel/integration/ApiConnection.dart';
import 'package:nice_travel/integration/json/ScheduleJson.dart';
import 'package:nice_travel/model/Schedule.dart';

class ScheduleApiConnection {
  ScheduleApiConnection._();

  static final ScheduleApiConnection instance = new ScheduleApiConnection._();

  Future<List<Schedule>> getScheduleByCityName(String cityName,
      {int sizeElements = 5}) async {
    final url = ApiConnection.URL_API +
        "/schedule/city?cityName=$cityName&sizeElements=$sizeElements";
    return _formatFutureToSchedules(await http.Client().get(url));
  }

  Future<List<Schedule>> getSchedulesByIds(List<int> scheduleIds) async {
    String ids = '';
    scheduleIds..forEach((id) => ids += '&scheduleIds=$id');
    final url = ApiConnection.URL_API + '/schedule/ids?1=1$ids';
    print(url);
    return _formatFutureToSchedules(await http.Client().get(url));
  }

  Future<Response> createSchedule(String placeId, int numberDays) {
    final url = ApiConnection.URL_API +
        "/schedule?placeID=$placeId&numberDays=$numberDays";
    return http.post(url);
  }

  Future<Response> publishSchedule(int codSchedule) {
    final url =
        ApiConnection.URL_API + "/schedule/publish?scheduleId=$codSchedule";
    return http.post(url);
  }

  void deleteSchedule(int scheduleCod) {
   final url =  ApiConnection.URL_API + "/schedule/delete?scheduleId=$scheduleCod";
   http.delete(url);
  }

  Future<Response> voteTravelSchedule(int codSchedule) {
    final url =
        ApiConnection.URL_API + "/schedule/vote?scheduleId=$codSchedule";
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
