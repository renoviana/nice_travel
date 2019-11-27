import 'package:nice_travel/integration/ScheduleApiConnection.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:rxdart/rxdart.dart';

class ListScheduleBloc {
  var _listScheduleBloc = BehaviorSubject<List<Schedule>>.seeded([]);

  void loadSchedules() async {
    List<Schedule> lista =
        await ScheduleApiConnection.instance.getScheduleByCityName('Salvador');
    setListSchedule.add(lista);
  }

  Stream<List<Schedule>> get getListSchedule => _listScheduleBloc.stream;

  Sink<List<Schedule>> get setListSchedule => _listScheduleBloc.sink;
}

final listScheduleBloc = new ListScheduleBloc();
