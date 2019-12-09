import 'package:nice_travel/integration/ApiResponse.dart';
import 'package:nice_travel/integration/ScheduleApiConnection.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:rxdart/rxdart.dart';

import '../BlocHelper.dart';

class MyListScheduleBloc {
  var _listScheduleBloc =
      BehaviorSubject<ApiResponse<List<Schedule>>>.seeded(null);

  void loadSchedules(String userUID) async {
    setListSchedule.add(ApiResponse.loading());
    try {
      List<Schedule> lista =
          await ScheduleApiConnection.instance.getSchedulesByUserUID(userUID);
      setListSchedule.add(ApiResponse.completed(lista));
    } catch (e) {
      setListSchedule.add(ApiResponse.error(BlocHelper.getErrorMessage(e)));
    }
  }

  Stream<ApiResponse<List<Schedule>>> get getListSchedule =>
      _listScheduleBloc.stream;

  Sink<ApiResponse<List<Schedule>>> get setListSchedule =>
      _listScheduleBloc.sink;

  void clearList() {
    setListSchedule.add(ApiResponse.completed([]));
  }
}

final myListScheduleBloc = new MyListScheduleBloc();
