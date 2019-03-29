import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nice_travel/integration/ScheduleJson.dart';
import 'package:nice_travel/model/Schedule.dart';

class ApiConnection {
  Future<Response> getScheduleByCityName(String cityName, int sizeElements) {
    final url = "http://localhost:8080/schedule/city?cityName=$cityName&sizeElements=$sizeElements";
    return http.get(url);
  }

  List<Schedule> teste(Response response) {
    if (response.statusCode == 200) {
      return formatScheduleJson(response.body);
    }
    return [];
  }

  List<Schedule> formatScheduleJson(String json) {
    return ScheduleJson().parseScheduleJsonToSchedule(json);
  }

  handleError(error) {}
}
