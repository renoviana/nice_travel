import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nice_travel/integration/ApiConnection.dart';
import 'package:nice_travel/integration/json/ScheduleJson.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/model/SessionUser.dart';
import 'package:nice_travel/model/UserModel.dart';

class ScheduleApiConnection {
  ScheduleApiConnection._() {
    print('Calling ScheduleApiConnection');
  }

  static final ScheduleApiConnection instance = new ScheduleApiConnection._();

  Future<List<Schedule>> getScheduleByCityPlaceID(String placeID,
      {int sizeElements = 5}) async {
    final url = ApiConnection.URL_API +
        "/schedule/city?1=1"
            "${placeID != null ? "&placeID=$placeID" : ""}"
            "&sizeElements=$sizeElements";
    return _formatFutureToSchedules(await http.get(url));
  }

  Future<List<Schedule>> getSchedulesByIds(List<int> scheduleIds) async {
    String ids = '';
    scheduleIds..forEach((id) => ids += '&scheduleIds=$id');
    final url = ApiConnection.URL_API + '/schedule/ids?1=1$ids';
    return _formatFutureToSchedules(await http.get(url));
  }

  Future<List<Schedule>> getSchedulesByUserUID(userUID) async {
    final url = ApiConnection.URL_API + '/schedule/userUID?userUID=$userUID';
    return _formatFutureToSchedules(await http.get(url));
  }

  Future<Response> createSchedule(
      String placeId, int numberDays, SessionUser sessionUser) {
    final url = ApiConnection.URL_API +
        "/schedule?placeID=$placeId&numberDays=$numberDays"
            "&userUID=${sessionUser.uid}"
            "&userEmail=${sessionUser.email}"
            "&userName=${sessionUser.displayName}";
    return http.post(url);
  }

  Future<Response> publishSchedule(int codSchedule) {
    final url =
        ApiConnection.URL_API + "/schedule/publish?scheduleId=$codSchedule";
    return http.post(url);
  }

  Future<Schedule> duplicateSchedule(
      int codSchedule, SessionUser sessionUser) async {
    final url = ApiConnection.URL_API +
        "/schedule/duplicate?scheduleId=$codSchedule"
            "&userUID=${sessionUser.uid}"
            "&userEmail=${sessionUser.email}"
            "&userName=${sessionUser.displayName}";
    return _formatFutureToSchedule(await http.post(url));
  }

  Future<Response> deleteSchedule(int scheduleCod) {
    final url =
        ApiConnection.URL_API + "/schedule/delete?scheduleId=$scheduleCod";
    return http.delete(url);
  }

  Future<Response> voteTravelSchedule(int codSchedule, UserModel model) {
    final url = ApiConnection.URL_API +
        "/schedule/vote?scheduleId=$codSchedule&userUID=${model.sessionUser.uid}";
    return http.post(url);
  }

  List<Schedule> _formatFutureToSchedules(Response response) {
    if (response.statusCode == 200) {
      return _formatSchedulesJson(response.body);
    } else {
      print('${response.statusCode} - ${response.body}');
    }
    return [];
  }

  List<Schedule> _formatSchedulesJson(String json) {
    return ScheduleJson().parseScheduleJsonToSchedules(json);
  }

  Schedule _formatFutureToSchedule(Response response) {
    if (response.statusCode == 200) {
      return _formatScheduleJson(response.body);
    } else {
      print('${response.statusCode} - ${response.body}');
    }
    return null;
  }

  Schedule _formatScheduleJson(String json) {
    return ScheduleJson().parseScheduleJsonToSchedule(json);
  }

  Future<Response> payment(String token, String userUID) {
    final url = ApiConnection.URL_API +
        "/payment?token=$token&userUID=$userUID";
    return http.post(url);
  }
}
