import 'package:nice_travel/integration/ScheduleDayApiConnection.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:rxdart/rxdart.dart';

class ListScheduleDayBloc {
  var _listScheduleDayBloc = BehaviorSubject<List<ScheduleDay>>.seeded(null);

  void loadSchedules(int scheduleCod) async {
    List<ScheduleDay> lista = await ScheduleDayApiConnection.instance
        .getScheduleDayByCodSchedule(scheduleCod);
    setListScheduleDay.add(lista);
  }

  Stream<List<ScheduleDay>> get getListScheduleDay =>
      _listScheduleDayBloc.stream;

  Sink<List<ScheduleDay>> get setListScheduleDay => _listScheduleDayBloc.sink;
}

final listScheduleDayBloc = new ListScheduleDayBloc();
