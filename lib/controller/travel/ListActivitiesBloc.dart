import 'package:nice_travel/integration/AcitivityApiConnection.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:rxdart/rxdart.dart';

class ListActivitiesBloc {

  var _listActivityBloc = BehaviorSubject<List<Activity>>.seeded(null);

  void loadActivity(int scheduleDayId) async {
    listActivitiesBloc.setListActivity.add(null);
    List<Activity> lista =
        await ActivityApiConnection.instance.getActiviesByScheduleDay(scheduleDayId);
    setListActivity.add(lista);
  }

  Stream<List<Activity>> get getListActivity => _listActivityBloc.stream;
  Sink<List<Activity>> get setListActivity => _listActivityBloc.sink;
}

final listActivitiesBloc = new ListActivitiesBloc();
