import 'package:nice_travel/integration/ApiConnection.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:rxdart/rxdart.dart';

class ListScheduleDayBloc {
  ApiConnection apiConnection = new ApiConnection();

  var _listScheduleDayBloc = BehaviorSubject<List<ScheduleDay>>.seeded([]);

  void loadSchedules(int scheduleCod) async {
    List<ScheduleDay> lista =
        await apiConnection.getScheduleDayByCodSchedule(scheduleCod);
    setListScheduleDay.add(lista);
  }

  Stream<List<ScheduleDay>> get getListScheduleDay => _listScheduleDayBloc.stream;
  Sink<List<ScheduleDay>> get setListScheduleDay => _listScheduleDayBloc.sink;
}

final listScheduleDayBloc = new ListScheduleDayBloc();
