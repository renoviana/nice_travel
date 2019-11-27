import 'package:nice_travel/integration/ScheduleApiConnection.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:rxdart/rxdart.dart';

class MyListScheduleBloc {
  var _listScheduleBloc = BehaviorSubject<List<Schedule>>.seeded([]);

  void loadSchedules(List<int> ids) async {
    List<Schedule> lista =
        await ScheduleApiConnection.instance.getSchedulesByIds(ids);
    setListSchedule.add(lista);
  }

  Stream<List<Schedule>> get getListSchedule => _listScheduleBloc.stream;

  Sink<List<Schedule>> get setListSchedule => _listScheduleBloc.sink;
}

final myListScheduleBloc = new MyListScheduleBloc();
