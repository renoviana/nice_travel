import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nice_travel/integration/json/ScheduleDayJson.dart';
import 'package:nice_travel/integration/json/ScheduleJson.dart';
import 'package:nice_travel/model/Schedule.dart';

class ApiConnection {
  Future<Response> getScheduleByCityName(String cityName, int sizeElements) {
    final url =
        "http://localhost:8080/schedule/city?cityName=$cityName&sizeElements=$sizeElements";
    return http.get(url);
  }

  Future<Response> getScheduleDayByCodSchedule(int codSchedule) {
    final url = "http://localhost:8080/schedule/days?scheduleId=$codSchedule";
    return http.get(url);
  }

  Future<Response> publishSchedule(int codSchedule) {
    final url = "http://localhost:8080/schedule/publish?travelId=$codSchedule";
    return http.post(url);
  }

  Future<Response> createSchedule(String placeId, int  numberDays) {
    final url = "http://localhost:8080/schedule?placeID=$placeId&numberDays=$numberDays";
    return http.post(url);
  }


  List<Schedule> formatFutureToSchedules(Response response) {
    if (response.statusCode == 200) {
      return formatScheduleJson(response.body);
    }
    return [];
  }

  List<Schedule> formatScheduleJson(String json) {
    return ScheduleJson().parseScheduleJsonToSchedule(json);
  }


  List<ScheduleDay> formatFutureToSchedulesDay(Response response) {
    if (response.statusCode == 200) {
      return formatScheduleDayJson(response.body);
    }
    return [];
  }

  List<ScheduleDay> formatScheduleDayJson(String json) {
    return ScheduleDayJson().parseScheduleDayJsonToSchedule(json);
  }

}
