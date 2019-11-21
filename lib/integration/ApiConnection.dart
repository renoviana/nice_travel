import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nice_travel/integration/json/ScheduleDayJson.dart';
import 'package:nice_travel/integration/json/ScheduleJson.dart';
import 'package:nice_travel/model/Schedule.dart';

import 'json/ActivityJson.dart';

class ApiConnection {
//  static const URL_API = "https://nice-travel2.herokuapp.com";
  static const URL_API = "http://192.168.25.185:8080";

  Future<List<Schedule>> getScheduleByCityName(String cityName,
      {int sizeElements = 5}) async {
    final url = URL_API +
        "/schedule/city?cityName=$cityName&sizeElements=$sizeElements";
    return _formatFutureToSchedules(await http.Client().get(url));
  }

  Future<Response> publishSchedule(int codSchedule) {
    final url = URL_API + "/schedule/publish?scheduleId=$codSchedule";
    return http.post(url);
  }

  Future<Response> createSchedule(String placeId, int numberDays) {
    final url = URL_API + "/schedule?placeID=$placeId&numberDays=$numberDays";
    return http.post(url);
  }

  //SCHEDULE DAY
  Future<ScheduleDay> addScheduleDay(int codSchedule) async {
    final url = URL_API + "/scheduleDay/add?scheduleId=$codSchedule";
    print(url);
    return _formatFutureToScheduleDay(await http.post(url));
  }

  Future<List<ScheduleDay>> getScheduleDayByCodSchedule(int codSchedule) async {
    final url = URL_API + "/scheduleDay/days?scheduleId=$codSchedule";
    return _formatFutureToSchedulesDay(await http.get(url));
  }

  //ACTIVITIES
  Future<List<Activity>> getActiviesByScheduleDay(int scheduleDayId) async {
    final url = URL_API +
        "/activity?scheduleDayId=$scheduleDayId";
    return _formatFutureToActivities(await http.Client().get(url));
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
      return _formatSchedulesDayJson(response.body);
    }
    return [];
  }

  List<ScheduleDay> _formatSchedulesDayJson(String json) {
    return ScheduleDayJson().parseScheduleDayJsonToSchedules(json);
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

  ScheduleDay _formatFutureToScheduleDay(Response response) {
    if (response.statusCode == 200) {
      return _formatScheduleDayJson(response.body);
    }
    return null;
  }


  ScheduleDay _formatScheduleDayJson(String json) {
    return ScheduleDayJson().parseScheduleDayJsonToSchedule(json);
  }
}
