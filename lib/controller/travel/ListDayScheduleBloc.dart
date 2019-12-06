import 'package:nice_travel/controller/BlocHelper.dart';
import 'package:nice_travel/integration/ApiResponse.dart';
import 'package:nice_travel/integration/ScheduleDayApiConnection.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:rxdart/rxdart.dart';

class ListScheduleDayBloc {
  var _listScheduleDayBloc =
      BehaviorSubject<ApiResponse<List<ScheduleDay>>>.seeded(null);

  void loadSchedules(int scheduleCod) async {
    setListScheduleDay.add(ApiResponse.loading());
    try {
      List<ScheduleDay> lista = await ScheduleDayApiConnection.instance
          .getScheduleDayByCodSchedule(scheduleCod);
      setListScheduleDay.add(ApiResponse.completed(lista));
    } catch (e) {
      setListScheduleDay.add(ApiResponse.error(BlocHelper.getErrorMessage(e)));
    }
  }

  Stream<ApiResponse<List<ScheduleDay>>> get getListScheduleDay =>
      _listScheduleDayBloc.stream;

  Sink<ApiResponse<List<ScheduleDay>>> get setListScheduleDay =>
      _listScheduleDayBloc.sink;
}

final listScheduleDayBloc = new ListScheduleDayBloc();
