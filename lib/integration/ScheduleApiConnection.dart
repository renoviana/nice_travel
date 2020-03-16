import 'package:nice_travel/integration/ApiConnectionHelper.dart';
import 'package:nice_travel/integration/json/ScheduleJson.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/model/SessionUser.dart';
import 'package:nice_travel/model/UserModel.dart';

class ScheduleApiConnection {
  ScheduleApiConnection._();

  static final ScheduleApiConnection instance = new ScheduleApiConnection._();

  Future<List<Schedule>> getScheduleByCityPlaceID(String placeID,
      {int sizeElements = 5}) async {
    final url = ApiConnectionHelper.URL_API +
        "/schedule/city?1=1"
            "${placeID != null ? "&placeID=$placeID" : ""}"
            "&sizeElements=$sizeElements";
    return _formatFutureToSchedules(await ApiConnectionHelper.get(url));
  }

  Future<List<Schedule>> getSchedulesByIds(List<int> scheduleIds) async {
    String ids = '';
    scheduleIds..forEach((id) => ids += '&scheduleIds=$id');
    final url = ApiConnectionHelper.URL_API + '/schedule/ids?1=1$ids';
    return _formatFutureToSchedules(await ApiConnectionHelper.get(url));
  }

  Future<List<Schedule>> getSchedulesByUserUID(userUID) async {
    final url =
        ApiConnectionHelper.URL_API + '/schedule/userUID?userUID=$userUID';
    return _formatFutureToSchedules(await ApiConnectionHelper.get(url));
  }

  Future<dynamic> createSchedule(
      String placeId, int numberDays, SessionUser sessionUser) {
    final url = ApiConnectionHelper.URL_API +
        "/schedule?placeID=$placeId&numberDays=$numberDays"
            "&userUID=${sessionUser.uid}"
            "&userEmail=${sessionUser.email}"
            "&userName=${sessionUser.displayName}";
    return ApiConnectionHelper.post(url);
  }

  Future<dynamic> publishSchedule(int codSchedule) {
    final url = ApiConnectionHelper.URL_API +
        "/schedule/publish?scheduleId=$codSchedule";
    return ApiConnectionHelper.post(url);
  }

  Future<Schedule> duplicateSchedule(
      int codSchedule, SessionUser sessionUser) async {
    final url = ApiConnectionHelper.URL_API +
        "/schedule/duplicate?scheduleId=$codSchedule"
            "&userUID=${sessionUser.uid}"
            "&userEmail=${sessionUser.email}"
            "&userName=${sessionUser.displayName}";
    return _formatFutureToSchedule(await ApiConnectionHelper.post(url));
  }

  Future<dynamic> deleteSchedule(int scheduleCod) {
    final url = ApiConnectionHelper.URL_API +
        "/schedule/delete?scheduleId=$scheduleCod";
    return ApiConnectionHelper.delete(url);
  }

  Future<dynamic> voteTravelSchedule(int codSchedule, UserModel model) {
    final url = ApiConnectionHelper.URL_API +
        "/schedule/vote?scheduleId=$codSchedule&userUID=${model.sessionUser.uid}";
    return ApiConnectionHelper.post(url);
  }

  List<Schedule> _formatFutureToSchedules(String responseResult) {
    return _formatSchedulesJson(responseResult);
  }

  List<Schedule> _formatSchedulesJson(String json) {
    return ScheduleJson().parseScheduleJsonToSchedules(json);
  }

  Schedule _formatFutureToSchedule(String responseResult) {
    return _formatScheduleJson(responseResult);
  }

  Schedule _formatScheduleJson(String json) {
    return ScheduleJson().parseScheduleJsonToSchedule(json);
  }
}
