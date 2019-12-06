import 'package:nice_travel/integration/AcitivityApiConnection.dart';
import 'package:nice_travel/integration/ApiResponse.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:rxdart/rxdart.dart';

import '../BlocHelper.dart';

class ListActivitiesBloc {
  var _listActivityBloc =
      BehaviorSubject<ApiResponse<List<Activity>>>.seeded(null);

  void loadActivity(int scheduleDayId) async {
    setListActivity.add(ApiResponse.loading());
    try {
      List<Activity> lista = await ActivityApiConnection.instance
          .getActiviesByScheduleDay(scheduleDayId);
      setListActivity.add(ApiResponse.completed(lista));
    } catch (e) {
      setListActivity.add(ApiResponse.error(BlocHelper.getErrorMessage(e)));
    }
  }

  Stream<ApiResponse<List<Activity>>> get getListActivity =>
      _listActivityBloc.stream;

  Sink<ApiResponse<List<Activity>>> get setListActivity =>
      _listActivityBloc.sink;

  void clearList() {
    setListActivity.add(ApiResponse.completed([]));
  }
}

final listActivitiesBloc = new ListActivitiesBloc();
