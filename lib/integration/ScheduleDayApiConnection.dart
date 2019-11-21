import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nice_travel/integration/ApiConnection.dart';
import 'package:nice_travel/integration/json/ScheduleDayJson.dart';
import 'package:nice_travel/model/Schedule.dart';

class ScheduleDayApiConnection {

  ScheduleDayApiConnection._();

  /// Provides an instance of this class corresponding to the default app.
  static final ScheduleDayApiConnection instance = new ScheduleDayApiConnection._();


  //SCHEDULE DAY
  Future<ScheduleDay> addScheduleDay(int codSchedule) async {
    final url = ApiConnection.URL_API + "/scheduleDay/add?scheduleId=$codSchedule";
    return _formatFutureToScheduleDay(await http.post(url));
  }

  Future<List<ScheduleDay>> getScheduleDayByCodSchedule(int codSchedule) async {
    final url = ApiConnection.URL_API + "/scheduleDay/days?scheduleId=$codSchedule";
    return _formatFutureToSchedulesDay(await http.get(url));
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
