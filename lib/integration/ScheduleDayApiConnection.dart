import 'package:nice_travel/integration/ApiConnectionHelper.dart';
import 'package:nice_travel/integration/json/ScheduleDayJson.dart';
import 'package:nice_travel/model/Schedule.dart';

class ScheduleDayApiConnection {
  ScheduleDayApiConnection._();

  static final ScheduleDayApiConnection instance =
      new ScheduleDayApiConnection._();

  Future<List<ScheduleDay>> getScheduleDayByCodSchedule(int codSchedule) async {
    final url = ApiConnectionHelper.URL_API +
        "/scheduleDay/days?scheduleId=$codSchedule";
    return _formatFutureToSchedulesDay(await ApiConnectionHelper.get(url));
  }

  Future<dynamic> deleteScheduleDay(int scheduleDayId) async {
    final url = ApiConnectionHelper.URL_API +
        "/scheduleDay/delete?scheduleDayId=$scheduleDayId";
    return await ApiConnectionHelper.delete(url);
  }

  Future<ScheduleDay> addScheduleDay(int codSchedule) async {
    final url = ApiConnectionHelper.URL_API +
        "/scheduleDay/add?scheduleId=$codSchedule";
    return _formatFutureToScheduleDay(await ApiConnectionHelper.post(url));
  }

  Future<dynamic> reorderDays(int from, int to) async {
    final url = ApiConnectionHelper.URL_API +
        "/scheduleDay/reorder?scheduleDayIdFrom=$from&scheduleDayIdTo=$to";
    return await ApiConnectionHelper.post(url);
  }

  List<ScheduleDay> _formatFutureToSchedulesDay(String responseResult) {
    return _formatSchedulesDayJson(responseResult);
  }

  List<ScheduleDay> _formatSchedulesDayJson(String json) {
    return ScheduleDayJson().parseScheduleDayJsonToSchedules(json);
  }

  ScheduleDay _formatFutureToScheduleDay(String responseResult) {
    return _formatScheduleDayJson(responseResult);
  }

  ScheduleDay _formatScheduleDayJson(String json) {
    return ScheduleDayJson().parseScheduleDayJsonToSchedule(json);
  }
}
