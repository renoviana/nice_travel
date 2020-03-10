
import 'package:mobx/mobx.dart';
import 'package:nice_travel/controller/travel/ListScheduleBloc.dart';
import 'package:nice_travel/integration/ApiResponse.dart';
import 'package:nice_travel/model/Schedule.dart';

part 'travel_controller.g.dart';

class TravelController = _TravelControllerBase with _$TravelController;
abstract class _TravelControllerBase with Store {

  initializeSchedules(){
    listScheduleBloc.loadSchedules(null);
  }

  Stream<ApiResponse<List<Schedule>>> getListSchedule(){
    return listScheduleBloc.getListSchedule;
  }
  loadSchedules(String placeID){
    listScheduleBloc.loadSchedules(placeID);
  }
}