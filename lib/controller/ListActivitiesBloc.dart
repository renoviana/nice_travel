import 'package:nice_travel/integration/ApiConnection.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:rxdart/rxdart.dart';

class ListActivitiesBloc {
  ApiConnection apiConnection = new ApiConnection();

  var _listActivityBloc = BehaviorSubject<List<Activity>>.seeded([]);

  void loadActivity(int scheduleDayId) async {
    List<Activity> lista =
        await apiConnection.getActiviesByScheduleDay(scheduleDayId);
    setListActivity.add(lista);
  }

  Stream<List<Activity>> get getListActivity => _listActivityBloc.stream;
  Sink<List<Activity>> get setListActivity => _listActivityBloc.sink;
}

final listActivitiesBloc = new ListActivitiesBloc();
