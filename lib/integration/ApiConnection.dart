import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nice_travel/integration/json/ScheduleDayJson.dart';
import 'package:nice_travel/integration/json/ScheduleJson.dart';
import 'package:nice_travel/model/Schedule.dart';

class ApiConnection {
  Future<List<Schedule>> getScheduleByCityName(String cityName, int sizeElements) async {
    final url =
        "http://localhost:8080/schedule/city?cityName=$cityName&sizeElements=$sizeElements";
    return _formatFutureToSchedules(await http.get(url));
  }

  Future<List<ScheduleDay>> getScheduleDayByCodSchedule(int codSchedule) async {
    final url = "http://localhost:8080/schedule/days?scheduleId=$codSchedule";
    return await _formatFutureToSchedulesDay(await http.get(url));
  }

  Future<Response> publishSchedule(int codSchedule) {
    final url = "http://localhost:8080/schedule/publish?travelId=$codSchedule";
    return http.post(url);
  }

  Future<Response> createSchedule(String placeId, int  numberDays) {
    final url = "http://localhost:8080/schedule?placeID=$placeId&numberDays=$numberDays";
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


  List<ScheduleDay> _formatFutureToSchedulesDay(Response response) {
    if (response.statusCode == 200) {
      return _formatScheduleDayJson(response.body);
    }
    return [];
  }

  List<ScheduleDay> _formatScheduleDayJson(String json) {
    return ScheduleDayJson().parseScheduleDayJsonToSchedule(json);
  }

}
