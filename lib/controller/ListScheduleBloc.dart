import 'package:nice_travel/controller/firebase.dart';
import 'package:nice_travel/integration/ApiConnection.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:rxdart/rxdart.dart';

class ListScheduleBloc {
  ApiConnection apiConnection = new ApiConnection();

  var _listScheduleBloc = BehaviorSubject<List<Schedule>>.seeded([]);

  void loadSchedules() async {
    List<Schedule> lista =
        await apiConnection.getScheduleByCityName('Salvador');
    setListSchedule.add(lista);
  }

  Stream<List<Schedule>> get getListSchedule => _listScheduleBloc.stream;
  Sink<List<Schedule>> get setListSchedule => _listScheduleBloc.sink;
}

final listScheduleBloc = new ListScheduleBloc();
